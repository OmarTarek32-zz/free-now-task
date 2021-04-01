//
//  DriversListViewSpy.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
import UIKit

@testable import FreeNow

class DriversListViewSpy: DriversListViewProtocol {
    
    // MARK: - Dependencies
    
    var interactor: DriversListViewToInteractorProtocol?
    
    // MARK: - Testing Properties
    
    var drivers: [DriverViewModel]?
    var error: (title: String, subtitle: String)?
    var isShowingErrorView = false
    var isShowingLoading = false
    
    // MARK: - Spy Functions
    
    func showDriversList(_ drivers: [DriverViewModel]) {
        self.drivers = drivers
    }
    
    func showLoading() {
        isShowingLoading = true
    }
    
    func hideLoading() {
        isShowingLoading = false
    }
    
    var retryViewEdgeInsets: UIEdgeInsets?
    
    func showErrorView(title: String, subtitle: String) {
        error = (title: title, subtitle: subtitle)
        isShowingErrorView = true
    }
    
    func hideErrorView() {
        isShowingErrorView = false
    }
}
