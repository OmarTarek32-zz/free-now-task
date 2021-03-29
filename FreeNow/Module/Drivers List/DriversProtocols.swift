//
//  DriversProtocols.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation

// MARK: - View Protocols

protocol DriversMapViewProtocol: DriversMapPresenterToViewProtocol {
    var interactor: DriversMapViewToInteractorProtocol? { get }
}

protocol DriversMapViewToInteractorProtocol {
    func viewLoaded()
}

// MARK: - Interactor Protocols

protocol DriversMapInteractorProtocol: DriversMapViewToInteractorProtocol {
    var presenter: DriversMapInteractorToPresenterProtocol { get }
    var repository: DriversInteractorToRepositoryProtocol { get }
}

protocol DriversMapInteractorToPresenterProtocol {
}

protocol DriversInteractorToRepositoryProtocol {
    func getDriversList(topLeftPointLat: Double, topLeftPointLong: Double, rightBottomPointLat: Double, rightBottomPointLong: Double, compeletion: @escaping (Result<Drivers, Error>) -> Void)
}


// MARK: - Presenter Protocols

protocol DriversMapPresenterProtocol: DriversMapInteractorToPresenterProtocol {
    var view: DriversMapPresenterToViewProtocol { get }
}

protocol DriversMapPresenterToViewProtocol {
}

// MARK: - Repository Protocols

protocol DriversRepositoryProtocol: DriversInteractorToRepositoryProtocol {
    var apiClient: APICleintProtocol { get }
}
