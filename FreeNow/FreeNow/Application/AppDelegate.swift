//
//  AppDelegate.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        startFlow()
        
        return true
    }
    
    func startFlow() {
        window?.rootViewController = DriverConfigurator.asymble(type: .listView)
        window?.makeKeyAndVisible()
    }

}

