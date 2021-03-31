//
//  LoadingViewCapable.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//


import Foundation
import UIKit

protocol LoadingViewCapable {
    func showLoading()
    func hideLoading()
}

extension LoadingViewCapable where Self: UIViewController {
    
    func showLoading() {
        let loader = LoadingView.shared
        view.addSubview(loader)
        view.bringSubviewToFront(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        loader.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        let loader = LoadingView.shared
        loader.removeFromSuperview()
    }
}

class LoadingView: UIView {
    
     var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .white
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    private init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        addSubview(activityIndicator)
        backgroundColor = .clear
        activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let shared = LoadingView()
}
