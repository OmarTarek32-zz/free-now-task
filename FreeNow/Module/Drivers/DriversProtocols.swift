//
//  DriversProtocols.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation
import UIKit

// MARK: - View Protocols

protocol DriversMapViewProtocol: DriversMapPresenterToViewProtocol {
    var interactor: DriversMapViewToInteractorProtocol? { get }
    var router: DriversMapViewToRouterProtocol? { get }
}

protocol DriversMapViewToInteractorProtocol {
    func requestAccessLocationPermissionIfNeeded()
    func fetchDrivers(in frame: MapFrameCoordinate)
}

protocol DriversMapViewToRouterProtocol {
    func navigateToDriversList()
}

// MARK: - Interactor Protocols

protocol DriversMapInteractorProtocol: DriversMapViewToInteractorProtocol {
    var presenter: DriversMapInteractorToPresenterProtocol { get }
    var repository: DriversInteractorToRepositoryProtocol { get }
    var locationManager: DriversInteractorToLocationManagerProtocol { get }
}

protocol DriversMapInteractorToPresenterProtocol {
    func didReceiveDrivers(_ drivers: [Drivers.Driver])
    func didReceiveError(_ error: CustomNetworkError)
}

protocol DriversInteractorToRepositoryProtocol {
    func getDriversList(topLeftPointLat: Double, topLeftPointLong: Double, rightBottomPointLat: Double, rightBottomPointLong: Double, compeletion: @escaping (Result<Drivers, CustomNetworkError>) -> Void)
}

protocol DriversInteractorToLocationManagerProtocol {
     func requestAccessLocationPermissionIfNeeded()
}

// MARK: - Presenter Protocols

protocol DriversMapPresenterProtocol: DriversMapInteractorToPresenterProtocol {
    var view: DriversMapPresenterToViewProtocol? { get }
}

protocol DriversMapPresenterToViewProtocol: AnyObject, ErrorDisplaying {
    func addDriversOnMap(_ drivers: [DriverViewModel])
    func removeAllDriversFromMap()
}

// MARK: - Repository Protocols

protocol DriversRepositoryProtocol: DriversInteractorToRepositoryProtocol {
    var apiClient: APICleintProtocol { get }
}

// MARK: - Router Protocols

protocol DriversRouterProtocol: DriversMapViewToRouterProtocol {
    var sourceViewController: (UIViewController & Navigatable & UIViewControllerTransitioningDelegate)? { get }
}

