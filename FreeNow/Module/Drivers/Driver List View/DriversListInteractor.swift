//
//  DriversListInteractor.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation

class DriversListInteractor {
    
    // MARK: - Dependencies
    
    var presenter: DriversListInteractorToPresenterProtocol
    var repository: DriversInteractorToRepositoryProtocol
    
    // MARK: - Properties
    private let hamburgMapFrame = MapFrameCoordinate(topLeftPointLat: 53.694865,
                                                     topleftPointLong: 9.757589,
                                                     BottomRightPointLat: 53.394655,
                                                     BottomRightPointLong: 10.099891)
    // MARK: - Initializers
    
    init(presenter: DriversListInteractorToPresenterProtocol,
         repository: DriversInteractorToRepositoryProtocol) {
        
        self.presenter = presenter
        self.repository = repository
    }
    
}

extension DriversListInteractor: DriversListInteractorProtocol {
    
    func fetchAllDriversInHambureg() {
        presenter.showLoading()
        repository.getDriversList(topLeftPointLat: hamburgMapFrame.topLeftPointLat,
                                  topLeftPointLong: hamburgMapFrame.topleftPointLong,
                                  rightBottomPointLat: hamburgMapFrame.BottomRightPointLat,
                                  rightBottomPointLong: hamburgMapFrame.BottomRightPointLong) { [weak self] result in
            switch result {
            case .success(let drivers):
                self?.presenter.didReceiveDrivers(drivers.poiList)
            case .failure(let error):
                self?.presenter.didReceiveError(error)
            }
            self?.presenter.hideLoading()
        }
    }
}
