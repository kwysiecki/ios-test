//
//  FlightListViewModelWrapperTests.swift
//  TestTaskTests
//
//  Created by ANDRIOS Krzysztof Wysiecki on 03/07/2024.
//

import XCTest
import Combine
@testable import TestTask

class FlightListViewModelWrapperTests: XCTestCase {
    var viewModel: FlightListViewModel!
    var viewModelWrapper: FlightListViewModelWrapper!
    var mockService: MockFlightsService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockFlightsService()
        viewModel = FlightListViewModel(flightsService: mockService)
        viewModelWrapper = FlightListViewModelWrapper(viewModel: viewModel)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        viewModelWrapper = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModelWrapper.flights.isEmpty)
        XCTAssertEqual(viewModelWrapper.totalCost, 0.0)
    }
    
    func testFlightAdditionUpdatesWrapper() {
        addFlight(price: "100.0", duration: "3600.0")
        
        let expectation = XCTestExpectation(description: "Wrapper updates flight data")
        
        viewModelWrapper.$flights
            .sink { flights in
                XCTAssertEqual(flights.count, 1)
                XCTAssertEqual(flights.first?.price, 100.0)
                XCTAssertEqual(flights.first?.duration, 3600.0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModelWrapper.$totalCost
            .sink { totalCost in
                XCTAssertEqual(totalCost, 100.0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func testFlightRemovalUpdatesWrapper() {
        addFlight(price: "100.0", duration: "3600.0")
        
        viewModel.removeFlight(at: IndexSet(integer: 0))
        
        let expectation = XCTestExpectation(description: "Wrapper updates flight data")
        
        viewModelWrapper.$flights
            .sink { flights in
                XCTAssertTrue(flights.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModelWrapper.$totalCost
            .sink { totalCost in
                XCTAssertEqual(totalCost, 0.0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func addFlight(price: String, duration: String) {
        viewModel.newFlightPrice = price
        viewModel.newFlightDuration = duration
        viewModel.addFlight()
    }
}
