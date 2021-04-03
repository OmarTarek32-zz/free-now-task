//
//  CoreLocationExtension.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/3/21.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}
