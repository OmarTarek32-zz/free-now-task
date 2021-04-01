//
//  NetworkError.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import Foundation

enum CustomNetworkError: Error, LocalizedError {
    
    init(error: Error) {
        self = .unknowen(error.asAFError?.localizedDescription)
    }
    
    case canNotMapRequest
    case canNotDecodeObject
    case unknowen(String?)
    case generic
    
    public var localizedDescription: String {
        switch self {
        case .canNotMapRequest:
            return "Can not Send Request"
        case .canNotDecodeObject:
            return "Can not read data"
        case .generic:
            return "Something went wrong"
        case .unknowen(let message):
            return message ?? "Something went wrong"
            
        }
    }

}
