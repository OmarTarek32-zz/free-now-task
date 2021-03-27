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
}

struct DriverConfigurator {
    
    static func asymble(type: DriverConfiguratorTypes) -> UIViewController {
        switch type {
        case .listView:
            return asymbleDriversListView()
        }
    }
    
    private static func asymbleDriversListView() -> UIViewController {
        let driversViewController = DriversListViewController()
        return driversViewController
    }
}
