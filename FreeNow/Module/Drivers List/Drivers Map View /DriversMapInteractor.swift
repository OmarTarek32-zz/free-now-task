//
//  DriversMapInteractor.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import CoreLocation

class DriversMapInteractor {
    
    // MARK: - Dependencies
    
    var presenter: DriversMapInteractorToPresenterProtocol
    var repository: DriversInteractorToRepositoryProtocol
    var locationManager: DriversInteractorToLocationManagerProtocol
    
    // MARK: - Initializers
    
    init(presenter: DriversMapInteractorToPresenterProtocol,
         repository: DriversInteractorToRepositoryProtocol,
         locationManager: DriversInteractorToLocationManagerProtocol) {
        
        self.presenter = presenter
        self.repository = repository
        self.locationManager = locationManager
    }
    
}

extension DriversMapInteractor: DriversMapInteractorProtocol {
    
    func requestAccessLocationPermissionIfNeeded() {
        locationManager.requestAccessLocationPermissionIfNeeded()
    }
    
    func fetchDrivers(in frame: MapFrameCoordinate) {
        repository.getDriversList(topLeftPointLat: frame.topLeftPointLat,
                                  topLeftPointLong: frame.topleftPointLong,
                                  rightBottomPointLat: frame.BottomRightPointLat,
                                  rightBottomPointLong: frame.BottomRightPointLong) { [weak self] result in
            
            switch result {
            case .success(let drivers):
                self?.presenter.didReceiveDrivers(drivers.poiList)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
