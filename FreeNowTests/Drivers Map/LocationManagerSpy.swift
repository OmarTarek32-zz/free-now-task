//
//  LocationManagerMock.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
@testable import FreeNow

class LocationManagerSpy: DriversInteractorToLocationManagerProtocol {
    
    // MARK: - Testing Properties
    
    var isLocationAccessRequested = false
    
    // MARK: - Mock Functions
    
    func requestAccessLocationPermissionIfNeeded() {
        isLocationAccessRequested = true
    }
}
