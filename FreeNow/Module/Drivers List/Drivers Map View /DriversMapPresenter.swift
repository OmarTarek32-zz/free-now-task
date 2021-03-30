//
//  DriversMapPresenter.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import CoreLocation

class DriversMapPresenter: DriversMapPresenterProtocol {
    
    weak var view: DriversMapPresenterToViewProtocol?
    
    init(view: DriversMapPresenterToViewProtocol) {
        self.view = view
    }
    
    func map(_ driver: Drivers.Driver) -> DriverViewModel {
        DriverViewModel(id: driver.id,
                        coordinate: CLLocationCoordinate2D(latitude: driver.coordinate.latitude,
                                                           longitude: driver.coordinate.longitude),
                        state: driver.state,
                        type: driver.type,
                        heading: driver.heading)
    }
}

extension DriversMapPresenter: DriversMapInteractorToPresenterProtocol {
    
    func didReceiveDrivers(_ drivers: [Drivers.Driver]) {
        view?.removeAllDriversFromMap()
        view?.addDriversOnMap(drivers.map(map(_:)))
    }
    
    func didReceiveError(_ error: Error) {
        
    }
}
