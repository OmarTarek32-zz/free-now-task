//
//  DriversMapPresenterSpy.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
@testable import FreeNow

class DriversMapPresenterSpy: DriversMapPresenterProtocol {
    
    // MARK: - Testing Properties
    
    var drivers: [Drivers.Driver]?
    var error: Error?
    
    // MARK: - Dependencies
    
    var view: DriversMapPresenterToViewProtocol?
    
    // MARK: - Spy Functions
    
    func didReceiveDrivers(_ drivers: [Drivers.Driver]) {
        self.drivers = drivers
    }
    
    func didReceiveError(_ error: CustomNetworkError) {
        self.error = error
    }
}
