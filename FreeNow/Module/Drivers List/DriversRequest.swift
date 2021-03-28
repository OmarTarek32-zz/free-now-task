//
//  DriversRequest.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/28/21.
//

import Foundation

enum DriversRequest: RequestProtocol {
    
    case list(leftTopPointLat: Double, leftTopPointLong: Double, rightBottomPointLat: Double, rightBottomPointLong: Double)
    
    var url: String {
        switch self{
        case .list:
            return "https://poi-api.mytaxi.com/PoiService/poi/v1"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .list:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var parameters: Parameters? {
        switch self{
        case let .list(leftTopPointLat, leftTopPointLong, rightBottomPointLat, rightBottomPointLong):
            return["p1Lat": leftTopPointLat,
                   "p1Lon": leftTopPointLong,
                   "p2Lat": rightBottomPointLat,
                   "p2Lon": rightBottomPointLong]
        }
    }
}

//"https://poi-api.mytaxi.com/PoiService/poi/v1?p2Lat=53.394655&p1Lon=9.757589&p1Lat=53 .694865&p2Lon=10.099891"
