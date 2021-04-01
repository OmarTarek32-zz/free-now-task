//
//  DriversListInteractorTests.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/1/21.
//

import XCTest
@testable import FreeNow

class DriversListInteractorTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: DriversListInteractor!
    var repository: DriversRepositoryMock!
    var presenter: DriversListPresenterSpy!
    var apiClientSpy: APIClientSpy!
    
    // MARK: - Life Cycle Functions
    
    override func setUp() {
        super.setUp()
        
        apiClientSpy = APIClientSpy()
        repository = DriversRepositoryMock(apiClient: apiClientSpy)
        presenter = DriversListPresenterSpy()
        sut = DriversListInteractor(presenter: presenter,
                                   repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        
        repository = nil
        presenter = nil
        apiClientSpy = nil
        sut = nil
    }
    
    // MARK: - Tests
    
    func test_init() {
        // Given
        repository = DriversRepositoryMock(apiClient: APIClientSpy())
        presenter = DriversListPresenterSpy()
        
        // When
        sut = DriversListInteractor(presenter: presenter,
                                   repository: repository)
        // Then
        XCTAssertNotNil(sut.presenter)
        XCTAssertNotNil(sut.repository)
    }
    
    func test_fetchAllDriversInHambureg_nonEmptySuccess() {
        // when
        sut.fetchAllDriversInHambureg()
        repository.simulateGettingNonEmptySuccessRespons()
        // then
        XCTAssertFalse(presenter.drivers?.isEmpty ?? true)
    }
    
    func test_fetchAllDriversInHambureg_emptySuccess() {
        // when
        sut.fetchAllDriversInHambureg()
        repository.simulateGettingEmptySuccessRespons()
        // then
        XCTAssertTrue(presenter.drivers?.isEmpty ?? false)
    }
    
    func test_fetchAllDriversInHambureg_failure() {
        // when
        sut.fetchAllDriversInHambureg()
        repository.simulateGettingErrorRespons()
        // then
        XCTAssertNotNil(presenter.error)
    }
    
    func test_fetchAllDriversInHambureg_shouldShowLoadingBeforResponse() {
        // when
        sut.fetchAllDriversInHambureg()
        // then
        XCTAssertTrue(presenter.isShowingLoading)
    }
    
    func test_fetchAllDriversInHambureg_shouldHideLoadingAfterSuccessResponse() {
        // when
        sut.fetchAllDriversInHambureg()
        repository.simulateGettingEmptySuccessRespons()
        // then
        XCTAssertFalse(presenter.isShowingLoading)
    }
    
    func test_fetchAllDriversInHambureg_shouldHideLoadingAfterFailureResponse() {
        // when
        sut.fetchAllDriversInHambureg()
        repository.simulateGettingErrorRespons()
        // then
        XCTAssertFalse(presenter.isShowingLoading)
    }
    
    func test_fetchAllDriversInHambureg_shouldTriggerApiClient() {
        // when
        sut.fetchAllDriversInHambureg()
        // then
        XCTAssertNotNil(apiClientSpy.isRequestSent)
    }
    
}
