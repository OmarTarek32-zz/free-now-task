//
//  Navigatable.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation
import UIKit

enum PresentingStyle {
    case modal(animated: Bool = true)
    case push
}

protocol Route {
    var destination: UIViewController { get }
    var defaultStyle: PresentingStyle { get }
}

protocol Navigatable: class {
    func navigateTo(_ route: Route, beforNavigation: ((UIViewController) -> Void)?)
}

extension Navigatable where Self: UIViewController {
    
    func navigateTo(_ route: Route, beforNavigation: ((UIViewController) -> Void)?) {
        switch route.defaultStyle {
        case let .modal(animated):
            let destination = route.destination
            destination.modalPresentationStyle = modalPresentationStyle
            beforNavigation?(destination)
            present(destination, animated: animated, completion: nil)
        case .push:
            let navigationController = self.navigationController?.navigationController
            navigationController?.pushViewController(route.destination, animated: true)
        }
    }
}
