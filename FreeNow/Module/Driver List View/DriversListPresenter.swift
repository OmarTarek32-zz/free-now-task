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
    
    func didReceiveDrivers(_ drivers: [Drivers.Driver]) {
        view?.showDriversList(drivers.map(map(_:)))
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
