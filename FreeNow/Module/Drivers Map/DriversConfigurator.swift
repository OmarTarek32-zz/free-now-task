//
//  DriversConfigurator.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation
import UIKit

enum DriverConfiguratorTypes {
    case listView
    case mapView
}

struct DriverConfigurator {
    
    // MARK: - Public Functions
    
    static func asymble(type: DriverConfiguratorTypes) -> UIViewController {
        switch type {
        case .listView:
            return asymbleDriversListView()
            
        case .mapView:
            return asymbleDriversMapView()
        }
    }
    
    // MARK: - Private Functions
    
    private static func asymbleDriversListView() -> UIViewController {
        let driversViewController = DriversListViewController()
        let driversListPresnter = DriversListPresenter(view: driversViewController)
        let driversRepository = DriversRepository(apiClient: APICleint.shared)
        let driversListInteractor =  DriversListInteractor(presenter: driversListPresnter,
                                                           repository: driversRepository)
        driversViewController.interactor = driversListInteractor
        
        return driversViewController
    }
    
    private static func asymbleDriversMapView() -> UIViewController {
        
        let driversMapViewController = DriversMapViewController()
        let driversRepository = DriversRepository(apiClient: APICleint.shared)
        let driversMappresnter = DriversMapPresenter(view: driversMapViewController)
        let driversMapRouter = DriversRouter()
        let driversMapinteractor = DriversMapInteractor(presenter: driversMappresnter,
                                              repository: driversRepository,
                                              locationManager: LocationManager())
        driversMapRouter.sourceViewController = driversMapViewController
        driversMapViewController.interactor = driversMapinteractor
        driversMapViewController.router = driversMapRouter
        return driversMapViewController
    }
}
