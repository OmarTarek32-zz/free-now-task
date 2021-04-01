//
//  APIClientMock.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
@testable import FreeNow

class APIClientSpy: APICleintProtocol {
    
    // MARK: - Testing Properties
    
    var isRequestSent = false
    
    // MARK: - Mock Functions
    
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType : Model {
        
        isRequestSent = true
    }
}
