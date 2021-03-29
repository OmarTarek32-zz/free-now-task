//
//  Driver.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/28/21.
//

import Foundation

struct Drivers: Model {
    
    let poiList: [Driver]
    
    struct Driver: Model {
        
        let id: Int
        let coordinate: Coordinate
        let state: String
        let type: String
        let heading: Double
    }
}

struct Coordinate: Model {
    let latitude: Double
    let longitude: Double
}

struct MapFrameCoordinates {
    
    var topLeftPointLat: Double
    var topleftPointLong: Double
    var BottomRightPointLat: Double
    var BottomRightPointLong: Double
}
