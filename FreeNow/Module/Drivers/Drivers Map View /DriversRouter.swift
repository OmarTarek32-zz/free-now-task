//
//  DriversRouter.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation
import UIKit

class DriversRouter {
    weak var sourceViewController: (UIViewController & Navigatable & UIViewControllerTransitioningDelegate)?
}

extension DriversRouter: DriversMapViewToRouterProtocol {
    func navigateToDriversList() {
        sourceViewController?.navigateTo(DriversRouts.allDriversList) { destinationViewController in
            destinationViewController.transitioningDelegate = self.sourceViewController
            destinationViewController.modalPresentationStyle = .custom
        }
//        let destinationViewController = DriverConfigurator.asymble(type: .listView)
//        destinationViewController.transitioningDelegate = self.sourceViewController
//        destinationViewController.modalPresentationStyle = .custom
//        sourceViewController?.present(destinationViewController, animated: true, completion: nil)
    }
}

enum DriversRouts: Route {
    
    case allDriversList
    
    var destination: UIViewController {
        switch self {
        case .allDriversList:
            return DriverConfigurator.asymble(type: .listView)
        }
    }
    
    var defaultStyle: PresentingStyle {
        switch self {
        case .allDriversList:
            return .modal(animated: true)
        }
    }
}
