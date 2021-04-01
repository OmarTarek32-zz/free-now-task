//
//  FreeNowTests.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 3/27/21.
//

import XCTest
@testable import FreeNow

class DriversMapInteractorTests: XCTestCase {

    // MARK: - Properties
    
    var sut: DriversMapInteractor!
    var repository: DriversRepositoryMock!
    var presenter: DriversMapPresenterSpy!
    var locationManager: LocationManagerSpy!
    var apiClientSpy: APIClientSpy!
    
    // MARK: - Life Cycle Functions
    
    override func setUp() {
        super.setUp()
        
        apiClientSpy = APIClientSpy()
        repository = DriversRepositoryMock(apiClient: apiClientSpy)
        presenter = DriversMapPresenterSpy()
        locationManager = LocationManagerSpy()
        sut = DriversMapInteractor(presenter: presenter,
                                   repository: repository,
                                   locationManager: locationManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        repository = nil
        presenter = nil
        locationManager = nil
        sut = nil
    }
    
    // MARK: - Tests
    
    func test_init() {
        
        // Given
        repository = DriversRepositoryMock(apiClient: APIClientSpy())
        presenter = DriversMapPresenterSpy()
        locationManager = LocationManagerSpy()
        
        // When
        sut = DriversMapInteractor(presenter: presenter,
                                   repository: repository,
                                   locationManager: locationManager)
        // Then
        XCTAssertNotNil(sut.presenter)
        XCTAssertNotNil(sut.repository)
        XCTAssertNotNil(sut.locationManager)
    }
    
    func test_requestAccessLocationPermissionIfNeeded() {
        // Given
        // When
        sut.requestAccessLocationPermissionIfNeeded()
        // Then
        XCTAssertTrue(locationManager.isLocationAccessRequested)
    }
    
    func test_fetchDrivers_nonEmptySuccess() {
        // Given
        let mapFrameCoordinate = DriversStubs.createFrameCoordinate()
        // when
        sut.fetchDrivers(in: mapFrameCoordinate)
        repository.simulateGettingNonEmptySuccessRespons()
        // then
        XCTAssertFalse(presenter.drivers?.isEmpty ?? true)
    }
    
    func test_fetchDrivers_emptySuccess() {
        // Given
        let mapFrameCoordinate = DriversStubs.createFrameCoordinate()
        // when
        sut.fetchDrivers(in: mapFrameCoordinate)
        repository.simulateGettingEmptySuccessRespons()
        // then
        XCTAssertTrue(presenter.drivers?.isEmpty ?? false)
    }
    
    func test_fetchDrivers_failure() {
        // Given
        let mapFrameCoordinate = DriversStubs.createFrameCoordinate()
        // when
        sut.fetchDrivers(in: mapFrameCoordinate)
        repository.simulateGettingErrorRespons()
        // then
        XCTAssertNotNil(presenter.error)
    }
    
    func test_fetchDrivers_shouldTriggerApiClient() {
        // Given
        let mapFrameCoordinate = DriversStubs.createFrameCoordinate()
        // when
        sut.fetchDrivers(in: mapFrameCoordinate)
        // then
        XCTAssertNotNil(apiClientSpy.isRequestSent)
    }
    
}
