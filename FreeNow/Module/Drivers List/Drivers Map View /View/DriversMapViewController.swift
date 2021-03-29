//
//  DriversMapViewController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import UIKit

class DriversMapViewController: UIViewController, DriversMapViewProtocol {

    var interactor: DriversMapViewToInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.viewLoaded()
    }
}

extension DriversMapViewController {
    
}
