//
//  DriversMapViewSpy.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
import UIKit

@testable import FreeNow

class DriversMapViewSpy: DriversMapViewProtocol {
    
    // MARK: - Dependencies
    
    var interactor: DriversMapViewToInteractorProtocol?
    var router: DriversMapViewToRouterProtocol?
    
    // MARK: - Testing Properties
    
    var drivers: [DriverViewModel]?
    var isRemovedAllDriversFromMap = false
    var error: (title: String, subtitle: String)?
    var isShowingErrorView = false
    
    var retryViewEdgeInsets: UIEdgeInsets?
    
    func addDriversOnMap(_ drivers: [DriverViewModel]) {
        self.drivers = drivers
    }
    
    func removeAllDriversFromMap() {
        isRemovedAllDriversFromMap = true
    }
    
    func showErrorView(title: String, subtitle: String) {
        error = (title, subtitle)
        isShowingErrorView = true
    }
    
    func hideErrorView() {
        isShowingErrorView = false
    }
    
}
