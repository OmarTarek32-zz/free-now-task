//
//  APICleint.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation
import Alamofire

class APICleint {
    
    static let shared = APICleint()
    
    private init() {}
}

extension APICleint: APICleintProtocol {
    
    func send<ResponsType>(request: RequestProtocol, for type: ResponsType.Type ,compeletion: @escaping (Result<ResponsType, Error>) -> Void) where ResponsType: Model {
        
        Session.default.request(request).validate().responseObject(ResponsType.self, compeletion: compeletion)
    }
}