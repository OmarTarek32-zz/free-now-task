//
//  DriverViewModel.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import Foundation
import CoreLocation

struct DriverViewModel {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    let state: String
    let type: String
    let heading: Double
}
