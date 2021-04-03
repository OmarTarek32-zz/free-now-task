//
//  DriversListPresenterSpy.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
@testable import FreeNow

class DriversListPresenterSpy: DriversListPresenterProtocol {
    
    // MARK: - Testing Properties
    
    var drivers: [Drivers.Driver]?
    var error: Error?
    var isShowingLoading = false
    
    // MARK: - Dependencies
    
    var view: DriversListPresenterToViewProtocol?
    
    // MARK: - Spy Functions
    
    func didReceiveDrivers(_ drivers: [Drivers.Driver]) {
        self.drivers = drivers
    }
    
    func didReceiveError(_ error: CustomNetworkError) {
        self.error = error
    }
    
    func showLoading() {
        isShowingLoading = true
    }
    
    func hideLoading() {
        isShowingLoading = false
    }
    
}
