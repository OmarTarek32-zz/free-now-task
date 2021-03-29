//
//  DriversMapInteractor.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import CoreLocation

class DriversMapInteractor {
    
    var presenter: DriversMapInteractorToPresenterProtocol
    var repository: DriversInteractorToRepositoryProtocol
    var locationManager: DriversInteractorToLocationManagerProtocol
    
    init(presenter: DriversMapInteractorToPresenterProtocol,
         repository: DriversInteractorToRepositoryProtocol,
         locationManager: DriversInteractorToLocationManagerProtocol) {
        
        self.presenter = presenter
        self.repository = repository
        self.locationManager = locationManager
    }
    
}

extension DriversMapInteractor: DriversMapInteractorProtocol {
    
    func viewStarted(with mapFrame: MapFrameCoordinates) {

        repository.getDriversList(topLeftPointLat: 53.694865,
                                  topLeftPointLong: 9.757589,
                                  rightBottomPointLat: 53.394655,
                                  rightBottomPointLong: 10.099891) { result in
            
            switch result {
            case .success(let drivers):
                debugPrint(drivers)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
