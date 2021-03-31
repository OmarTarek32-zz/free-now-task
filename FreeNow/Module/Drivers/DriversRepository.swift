//
//  DriversRepository.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/28/21.
//

import Foundation

struct DriversRepository {
    
    // MARK: - Dependencies
    
    var apiClient: APICleintProtocol
}

// MARK: - Extensions

extension DriversRepository: DriversRepositoryProtocol {
    
    // MARK: - Functions
    
    func getDriversList(topLeftPointLat: Double,
                        topLeftPointLong: Double,
                        rightBottomPointLat: Double,
                        rightBottomPointLong: Double,
                        compeletion: @escaping (Result<Drivers, Error>) -> Void) {
        
        let request = DriversRequest.list(leftTopPointLat: topLeftPointLat,
                                          leftTopPointLong: topLeftPointLong,
                                          rightBottomPointLat: rightBottomPointLat,
                                          rightBottomPointLong: rightBottomPointLong)
        
        apiClient.send(request: request,compeletion: compeletion)
    }
}
