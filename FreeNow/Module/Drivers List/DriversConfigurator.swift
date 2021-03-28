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
    
    static func asymble(type: DriverConfiguratorTypes) -> UIViewController {
        switch type {
        case .listView:
            return asymbleDriversListView()
            
        case .mapView:
            return asymbleDriversMapView()
        }
    }
    
    private static func asymbleDriversListView() -> UIViewController {
        let driversViewController = DriversListViewController()
        return driversViewController
    }
    
    private static func asymbleDriversMapView() -> UIViewController {
        let driversViewController = DriversMapViewController()
        return driversViewController
    }
}
