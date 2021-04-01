//
//  DriversListPresenter.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation
import CoreLocation

class DriversListPresenter {

    // MARK: - Dependencies
    
    weak var view: DriversListPresenterToViewProtocol?
    
    // MARK: - Initializers
    
    init(view: DriversListPresenterToViewProtocol) {
        self.view = view
    }
    
    // MARK: - Functions
    
    func map(_ driver: Drivers.Driver) -> DriverViewModel {
        DriverViewModel(id: abs(driver.id),
                        coordinate: CLLocationCoordinate2D(latitude: driver.coordinate.latitude,
                                                           longitude: driver.coordinate.longitude),
                        state: driver.state,
                        type: driver.type,
                        heading: driver.heading)
    }
    
}

// MARK: - Extensions

extension DriversListPresenter: DriversListPresenterProtocol {
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func didReceiveDrivers(_ drivers: [Drivers.Driver]) {
        
        if drivers.isEmpty {
            view?.showErrorView(title: "", subtitle: "We did not find any drivers in Hamburg")
        } else {
            view?.showDriversList(drivers.map(map(_:)))
        }
    }
    
    func didReceiveError(_ error: CustomNetworkError) {
        view?.showErrorView(title: "We have encountered a problem", subtitle: error.localizedDescription)
    }
}
