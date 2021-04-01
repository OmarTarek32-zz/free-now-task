//
//  File.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation

// MARK: - View Protocols

protocol DriversListViewProtocol: DriversListPresenterToViewProtocol {
    var interactor: DriversListViewToInteractorProtocol? { get }
}

protocol DriversListViewToInteractorProtocol {
    func fetchAllDriversInHambureg()
}

// MARK: - Interactor Protocols

protocol DriversListInteractorProtocol: DriversListViewToInteractorProtocol {
    var presenter: DriversListInteractorToPresenterProtocol { get }
    var repository: DriversInteractorToRepositoryProtocol { get }
}

protocol DriversListInteractorToPresenterProtocol {
    func didReceiveDrivers(_ drivers: [Drivers.Driver])
    func didReceiveError(_ error: CustomNetworkError)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter Protocols

protocol DriversListPresenterProtocol: DriversListInteractorToPresenterProtocol {
    var view: DriversListPresenterToViewProtocol? { get }
}

protocol DriversListPresenterToViewProtocol: AnyObject, LoadingViewCapable, ErrorDisplaying {
    func showDriversList(_ drivers: [DriverViewModel])
}
