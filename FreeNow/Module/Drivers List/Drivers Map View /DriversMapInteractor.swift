//
//  DriversMapInteractor.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation

class DriversMapInteractor {
    
    var presenter: DriversMapInteractorToPresenterProtocol
    var repository: DriversInteractorToRepositoryProtocol
    
    init(presenter: DriversMapInteractorToPresenterProtocol, repository: DriversInteractorToRepositoryProtocol) {
        self.presenter = presenter
        self.repository = repository
    }
    
}

extension DriversMapInteractor: DriversMapInteractorProtocol {
    func viewLoaded() {
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
