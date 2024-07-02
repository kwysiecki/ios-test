//
//  FlightListViewModelTests.swift
//  TestTaskTests
//
//  Created by ANDRIOS Krzysztof Wysiecki on 03/07/2024.
//

import XCTest
import Combine
@testable import TestTask

class FlightListViewModelTests: XCTestCase {
    var viewModel: FlightListViewModel!
    var mockService: MockFlightsService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockFlightsService()
        viewModel = FlightListViewModel(flightsService: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testInitialState() {
        addFlight(price: "100", duration: "3600")
        
        let flights = viewModel.flightSubject.value
        
        XCTAssertEqual(flights.count, 1)
        XCTAssertEqual(flights.first?.price, 100.0)
        XCTAssertEqual(flights.first?.duration, 3600.0)
        XCTAssertEqual(viewModel.totalCostSubject.value, 100.0)
    }
    
    func testRemoveFlight() {
        addFlight(price: "100", duration: "3600")
        
        viewModel.removeFlight(at: IndexSet(integer: 0))
        
        XCTAssertTrue(viewModel.flightSubject.value.isEmpty)
        XCTAssertEqual(viewModel.totalCostSubject.value, 0.0)
    }
    
    func testCalculateTotalCost() {
        addFlight(price: "100", duration: "3600")
        addFlight(price: "200", duration: "7200")
        
        XCTAssertEqual(viewModel.totalCostSubject.value, 300.0)
    }
    
    func addFlight(price: String, duration: String) {
        viewModel.newFlightPrice = price
        viewModel.newFlightDuration = duration
        viewModel.addFlight()
    }
}
