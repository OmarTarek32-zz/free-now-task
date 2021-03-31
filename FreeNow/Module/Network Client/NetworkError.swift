//
//  NetworkError.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation

enum AlamofireCustomError: Error, LocalizedError {
    case canNotMapRequest
    case canNotDecodeObject
    case unknowen
    
    var localizedDescription: String {
        switch self {
        case .canNotMapRequest:
            return "Can not Send Request"
        case .canNotDecodeObject:
            return "Can not read data"
        case .unknowen:
            return "Something went wrong"
        }
    }

}
