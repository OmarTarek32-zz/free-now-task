//
//  ErrorDisplaying.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/24/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol Retriable {
    @objc optional func retry()
}

protocol ErrorDisplaying: Retriable {
    
    var retryViewEdgeInsets: UIEdgeInsets? { get }
    func showErrorView(title: String, subtitle: String)
    func hideErrorView()
}

extension ErrorDisplaying where Self: UIViewController {
    
    var retryViewEdgeInsets: UIEdgeInsets? {
        return UIEdgeInsets.zero
    }
    
    func showErrorView(title: String, subtitle: String) {
        let errorView = ErrorView.instanceFromNib()
        errorView.configure(title: title, subtitle: subtitle)
        if let retry = retry {
            errorView.onRetry {
                errorView.removeFromSuperview()
                retry()
            }
        }
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: retryViewEdgeInsets?.left ?? 0).isActive = true
        errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: retryViewEdgeInsets?.right ?? 0).isActive = true
        errorView.topAnchor.constraint(equalTo: view.topAnchor,
                                       constant: retryViewEdgeInsets?.top ?? 0).isActive = true
        errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                          constant: retryViewEdgeInsets?.bottom ?? 0).isActive = true
    }
  
    
    func hideErrorView() {
        view.subviews.forEach { if $0 is ErrorView { $0.removeFromSuperview() }}
    }
}
