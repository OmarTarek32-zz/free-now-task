//
//  LocationManager.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: - Properties
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
}

// MARK: - Extensions

extension LocationManager: DriversInteractorToLocationManagerProtocol {
    
    func requestAccessLocationPermissionIfNeeded() {
        guard locationManager.authorizationStatus == .denied ||
                locationManager.authorizationStatus == .notDetermined ||
                locationManager.authorizationStatus == .restricted else { return }
        
        locationManager.requestWhenInUseAuthorization()
    }
    
}
