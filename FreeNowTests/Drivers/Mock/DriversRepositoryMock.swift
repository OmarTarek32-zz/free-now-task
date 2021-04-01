//
//  DriversRepositoryMock.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import Foundation
@testable import FreeNow

class DriversRepositoryMock: DriversRepositoryProtocol {
    
    // MARK: - Dependencies
    
    let apiClient: APICleintProtocol
    
    init(apiClient: APIClientSpy) {
        self.apiClient = apiClient
    }
    
    // MARK: - Testing Properties
    
    var compeletion: ((Result<Drivers, CustomNetworkError>) -> Void)?
    
    // MARK: - Mock Behaviour
    
    func successResponsStub() -> Drivers {
        DriversStubs.createDriverSuccessData()
    }
    
    func simulateGettingEmptySuccessRespons() {
        compeletion?(Result.success(Drivers(poiList: [])))
    }
    
    func simulateGettingNonEmptySuccessRespons() {
        compeletion?(Result.success(successResponsStub()))
    }
    
    func simulateGettingErrorRespons() {
        compeletion?(Result.failure(CustomNetworkError.canNotDecodeObject))
    }
    
    // MARK: - Mock Function
    
    func getDriversList(topLeftPointLat: Double,
                        topLeftPointLong: Double,
                        rightBottomPointLat: Double,
                        rightBottomPointLong: Double,
                        compeletion: @escaping (Result<Drivers, CustomNetworkError>) -> Void) {
        self.compeletion = compeletion
    }
}
