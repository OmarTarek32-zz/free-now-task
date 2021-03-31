//
//  DriversMapViewController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import UIKit
import MapKit

class DriversMapViewController: UIViewController, Navigatable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var allDriversButton: UIButton!
    @IBOutlet private weak var driversListViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var driversListView: DriversOnMapListView! {
        didSet {
            driversListView.delegate = self
        }
    }
    @IBOutlet private weak var mapView: DriversMapView! {
        didSet {
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.showsCompass = false
        }
    }
    
    // MARK: - Dependencies
    
    var interactor: DriversMapViewToInteractorProtocol?
    var router: DriversMapViewToRouterProtocol?
    
    // MARK: - Private Properties
    
    private var circularAnimationController = CircularAnimationController()
    private var isBottomSheetOpen = false
    private var bottomSheetMaxBottomMargin: CGFloat = 0
    private var bottomSheetMinBottomMargin: CGFloat = -175
    private let hamburgMapFrame = MapFrameCoordinate(topLeftPointLat: 53.694865,
                                                     topleftPointLong: 9.757589,
                                                     BottomRightPointLat: 53.394655,
                                                     BottomRightPointLong: 10.099891)
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.requestAccessLocationPermissionIfNeeded()
        interactor?.fetchDrivers(in: hamburgMapFrame)
        mapView.displayArea(in: hamburgMapFrame)
        driversListView.didTapOnToggleView = {
            self.toggleListVisabilty()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.driversListViewBottomConstraint.constant = bottomSheetMinBottomMargin
    }
    
    // MARK: - Functions
    
    func toggleListVisabilty() {
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.2,
                       options: UIView.AnimationOptions.curveEaseInOut,
                       animations: {
                        self.driversListViewBottomConstraint.constant = self.isBottomSheetOpen ? self.bottomSheetMinBottomMargin : self.bottomSheetMaxBottomMargin
                        self.view.layoutIfNeeded()
                       }, completion: { _ in
                        self.isBottomSheetOpen.toggle()
                       })
    }
    
    @IBAction private func allDriversAction(_ sender: UIButton) {
        router?.navigateToDriversList()
    }
    
}

// MARK: - Extensions

extension DriversMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        interactor?.fetchDrivers(in: self.mapView.currentMapFrameCoordinates)
    }
}

extension DriversMapViewController: DriversMapViewProtocol {
   
    func addDriversOnMap(_ drivers: [DriverViewModel]) {
        mapView.addDrivers(drivers)
        driversListView.addDrivers(drivers)
    }
    
    func removeAllDriversFromMap() {
        mapView.removeAnnotations(mapView.annotations)
    }
}

extension DriversMapViewController: DriversOnMapListViewDelegate {
    
    func driversOnMapListView(_ driversOnMapListView: DriversOnMapListView, didSelect driver: DriverViewModel, at indexPath: IndexPath) {
        
        let annotation = mapView.annotations.first {
            $0.coordinate.latitude == driver.coordinate.latitude && $0.coordinate.longitude == driver.coordinate.longitude }
        mapView.selectAnnotation(annotation!, animated: false)
    }
}

extension DriversMapViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        circularAnimationController.transitionMode = .present
        circularAnimationController.startingPoint = allDriversButton.center
        circularAnimationController.circleColor = allDriversButton.backgroundColor!
        return circularAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        circularAnimationController.transitionMode = .dismiss
        circularAnimationController.startingPoint = allDriversButton.center
        circularAnimationController.circleColor = allDriversButton.backgroundColor!
        return circularAnimationController
    }
}
