//
//  DriversListPresnterTests.swift
//  FreeNowTests
//
//  Created by Omar Tarek on 4/2/21.
//

import Foundation
import XCTest
@testable import FreeNow

class DriversListPresnterTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: DriversListPresenter!
    var view: DriversListViewSpy!

    // MARK: - Life Cycle Functions
    
    override func setUp() {
        super.setUp()
        
        view = DriversListViewSpy()
        sut = DriversListPresenter(view: view)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        sut = nil
    }
    
    func test_init() {
        // Given
        view = DriversListViewSpy()
        // When
        sut = DriversListPresenter(view: view)
        // Then
        XCTAssertNotNil(sut.view)
    }
    
    func test_map() {
        // Given
        let driver = DriversStubs.createDriver()
        // When
        let driverViewModel = sut.map(driver)
        // Then
        XCTAssertEqual(driver.id, driverViewModel.id)
        XCTAssertEqual(driver.heading, driverViewModel.heading)
        XCTAssertEqual(driver.state, driverViewModel.state)
        XCTAssertEqual(driver.type, driverViewModel.type)
        XCTAssertEqual(driver.coordinate.latitude, driverViewModel.coordinate.latitude)
        XCTAssertEqual(driver.coordinate.longitude, driverViewModel.coordinate.longitude)
    }
    
    func test_didReceiveDrivers_notEmpty() {
        // Given
        let drivers = DriversStubs.createDriversArray()
        // When
        sut.didReceiveDrivers(drivers)
        // Then
        XCTAssertFalse(view.drivers?.isEmpty ?? true)
    }
    
    func test_didReceiveDrivers_dataShouldMatch() {
        // Given
        let drivers = DriversStubs.createDriversArray()
        // When
        sut.didReceiveDrivers(drivers)
        // Then
        XCTAssertNotNil(view.drivers?.first)
        XCTAssertEqual(view.drivers!.first?.id, drivers.first?.id)
        XCTAssertNotNil(view.drivers?.last)
        XCTAssertEqual(view.drivers!.last?.id, drivers.last?.id)
    }
    
    func test_didReceiveDrivers_withEmptyData_shouldShowEmptyView() {
        // Given
        let drivers: [Drivers.Driver] = []
        // When
        sut.didReceiveDrivers(drivers)
        // Then
        XCTAssertNotNil(view.error)
    }
    
    func test_showLoading_shouldTriggerViewShowLoading() {
        // When
        sut.showLoading()
        // Then
        XCTAssertTrue(view.isShowingLoading)
    }
    
    func test_hideLoading_shouldTriggerViewHideLoading() {
        // When
        sut.hideLoading()
        // Then
        XCTAssertFalse(view.isShowingLoading)
    }
    
    func test_didReceiveError() {
        // Given
        let error = CustomNetworkError.canNotMapRequest
        // When
        sut.didReceiveError(error)
        // then
        XCTAssertTrue(view.isShowingErrorView)
    }
    
    func test_didReceiveError_errorMessageMatches() {
        // Given
        let error = CustomNetworkError.canNotMapRequest
        // When
        sut.didReceiveError(error)
        // then
        XCTAssertEqual(view.error?.subtitle, error.localizedDescription)
    }

}
