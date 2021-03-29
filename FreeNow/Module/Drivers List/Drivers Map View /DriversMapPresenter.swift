//
//  DriversMapPresenter.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/29/21.
//

import Foundation

class DriversMapPresenter: DriversMapPresenterProtocol {
    
    var view: DriversMapPresenterToViewProtocol
    
    init(view: DriversMapPresenterToViewProtocol) {
        self.view = view
    }
}
