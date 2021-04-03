//
//  DriversMapViewController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import UIKit
import MapKit

class DriversMapViewController: UIViewController {
    
    // MARK: - Constants
    
    struct Animation {
        struct Toggle {
            static let duration: Double = 0.7
            static let delay: Double = 0
            static let springDamping: CGFloat = 0.5
            static let initialSpringVelocity: CGFloat = 0.2
            
        }
    }
    
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
            mapView.register(CarsAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            mapView.register(CarsClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)

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
    
    private var drivers: [DriverViewModel] = []
    private var selectedAnnotation: MKAnnotation?
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.requestAccessLocationPermissionIfNeeded()
        interactor?.fetchDrivers(in: hamburgMapFrame)
        mapView.displayArea(in: hamburgMapFrame)
        driversListView.didTapOnToggleView = { [weak self] in self?.toggleListVisabilty() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.isRotateEnabled = false
        self.driversListViewBottomConstraint.constant = bottomSheetMinBottomMargin
    }
    
    deinit {
        mapView.delegate = nil
    }

    // MARK: - Functions
    
    func toggleListVisabilty() {
        
        UIView.animate(withDuration: Animation.Toggle.duration,
                       delay: Animation.Toggle.delay,
                       usingSpringWithDamping: Animation.Toggle.springDamping,
                       initialSpringVelocity: Animation.Toggle.initialSpringVelocity,
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

extension DriversMapViewController: ErrorDisplaying {
    func showErrorView(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Localization.string(for: .driversMapDismiss), style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension DriversMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        interactor?.fetchDrivers(in: self.mapView.currentMapFrameCoordinates)
    }
}

extension DriversMapViewController: DriversMapViewProtocol {
   
    func addDriversOnMap(_ drivers: [DriverViewModel]) {
        mapView.addDrivers(drivers)
        self.drivers = drivers
        driversListView.addDrivers(drivers)
    }
    
    func removeAllDriversFromMap() {
        mapView.removeAnnotations(mapView.annotations)
    }
}

extension DriversMapViewController: DriversOnMapListViewDelegate {
    
    func driversOnMapListView(_ driversOnMapListView: DriversOnMapListView, didSelect driver: DriverViewModel, at indexPath: IndexPath) {
        
        if let annotation = mapView.annotations.first(where: { $0.coordinate == drivers[indexPath.row].coordinate}) as? CarsAnnotationViewModel {
            mapView.markAnnotationSelected(annotation)
        }
    }
}

extension DriversMapViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        circularAnimationController.transitionMode = .present
        circularAnimationController.startingPoint = allDriversButton.center
        circularAnimationController.circleColor = allDriversButton.backgroundColor ?? .white
        return circularAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        circularAnimationController.transitionMode = .dismiss
        circularAnimationController.startingPoint = allDriversButton.center
        circularAnimationController.circleColor = allDriversButton.backgroundColor ?? .white
        return circularAnimationController
    }
}
