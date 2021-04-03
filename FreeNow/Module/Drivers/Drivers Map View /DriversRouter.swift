//
//  DriversRouter.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation
import UIKit

class DriversRouter {
    weak var sourceViewController: (UIViewController & UIViewControllerTransitioningDelegate)?
}

extension DriversRouter: DriversMapViewToRouterProtocol {
    func navigateToDriversList() {
        let destinationViewController = DriverConfigurator.asymble(type: .listView)
        destinationViewController.transitioningDelegate = self.sourceViewController
        destinationViewController.modalPresentationStyle = .custom
        sourceViewController?.present(destinationViewController, animated: true, completion: nil)
    }
}
