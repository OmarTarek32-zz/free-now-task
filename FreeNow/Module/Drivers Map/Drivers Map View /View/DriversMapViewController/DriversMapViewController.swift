//
//  DriversMapViewController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import UIKit
import MapKit

class DriversMapViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var driversListView: DriversOnMapListView! {
        didSet {
            driversListView.delegate = self
        }
    }
    @IBOutlet private weak var mapView: DriversMapView! {
        didSet {
            mapView.delegate = self
            mapView.showsUserLocation = true
        }
    }
    
    // MARK: - Dependencies
    
    var interactor: DriversMapViewToInteractorProtocol?
    
    // MARK: - Properties
    
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
