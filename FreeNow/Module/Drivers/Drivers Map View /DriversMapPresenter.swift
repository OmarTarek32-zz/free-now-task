//
//  DriversMapPresenter.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import CoreLocation

class DriversMapPresenter: DriversMapPresenterProtocol {
    
    // MARK: - Dependencies
    
    weak var view: DriversMapPresenterToViewProtocol?
    
    // MARK: - Initializers
    
    init(view: DriversMapPresenterToViewProtocol) {
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

extension DriversMapPresenter: DriversMapInteractorToPresenterProtocol {
    
    func didReceiveDrivers(_ drivers: [Drivers.Driver]) {
        view?.removeAllDriversFromMap()
        view?.addDriversOnMap(drivers.map(map(_:)))
    }
    
    func didReceiveError(_ error: CustomNetworkError) {
        view?.showErrorView(title: "We have encountered a problem", subtitle: error.localizedDescription)
    }
}
