//
//  LocationManager.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
}

extension LocationManager: DriversInteractorToLocationManagerProtocol {
    
    func requestAccessLocationPermissionIfNeeded() {
        guard locationManager.authorizationStatus == .denied ||
                locationManager.authorizationStatus == .notDetermined ||
                locationManager.authorizationStatus == .restricted else { return }
        
        locationManager.requestWhenInUseAuthorization()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
}
