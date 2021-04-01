//
//  DriversStubs.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
@testable import FreeNow

class DriversStubs {
    
    static func createFrameCoordinate() -> MapFrameCoordinate {
        return MapFrameCoordinate(topLeftPointLat: 50.0,
                                  topleftPointLong: 50.0,
                                  BottomRightPointLat: 100.0,
                                  BottomRightPointLong: 100.0)
    }
    
    static func createDriver() -> Drivers.Driver {
        return Drivers.Driver(id: 1,
                              coordinate: Coordinate(latitude: 53.55, longitude: 9.88),
                              state: "ACTIVE",
                              type: "TAXI",
                              heading: 175.5)
    }
    
    static func createDriversArray() -> [Drivers.Driver] {
        return [Drivers.Driver(id: 1,
                               coordinate: Coordinate(latitude: 51.55, longitude: 9.00),
                               state: "ACTIVE",
                               type: "TAXI",
                               heading: 175.5),
                Drivers.Driver(id: 2,
                               coordinate: Coordinate(latitude: 52.35, longitude: 10.48),
                               state: "INACTIVE",
                               type: "LIMOUSINE",
                               heading: 90.0),
                Drivers.Driver(id: 3,
                               coordinate: Coordinate(latitude: 53.55, longitude: 9.88),
                               state: "ACTIVE",
                               type: "TAXI",
                               heading: 100.00)
        ]
    }
    
    static func createDriverSuccessData() -> Drivers {
        return Drivers(poiList: createDriversArray())
    }
}
