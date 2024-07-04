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
    
    var flightListViewModel: FlightListViewModel!
    var flightsService: MockFlightsService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        flightsService = MockFlightsService()
        flightListViewModel = FlightListViewModel(flightsService: flightsService)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        flightListViewModel = nil
        flightsService = nil
        cancellables = nil
    }
    
    func testFetchFlights() throws {
        let expectation = self.expectation(description: "Fetch Flights")
        
        flightListViewModel.$flights
            .dropFirst()
            .sink { flights in
                XCTAssertEqual(flights.count, 2)
                XCTAssertEqual(flights.first?.flight.price, 100)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        flightListViewModel.fetchFlights()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testCalculateTotalCost() throws {
        let expectation = self.expectation(description: "Calculate Total Cost")
        
        flightListViewModel.$totalCost
            .dropFirst()
            .sink { totalCost in
                XCTAssertEqual(totalCost, 300)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        flightListViewModel.calculateTotalCost()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testAddFlight() throws {
        let expectation = self.expectation(description: "Add Flight")
        
        flightListViewModel.$flights
            .dropFirst(1)
            .sink { flights in
                XCTAssertEqual(flights.count, 2)
                XCTAssertEqual(flights.last?.flight.price, 200)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        flightListViewModel.addFlight(price: 200, duration: 2.0)
        
        waitForExpectations(timeout: 8, handler: nil)
    }
    
    func testRemoveFlight() throws {
        let expectation = self.expectation(description: "Remove Flight")
        
        flightListViewModel.$flights
            .dropFirst()
            .first()
            .sink { flights in
                XCTAssertEqual(flights.count, 2)
                XCTAssertEqual(flights.first?.flight.price, 100)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        flightListViewModel.removeFlight(at: IndexSet(integer: 0))
        
        waitForExpectations(timeout: 8, handler: nil)
    }
}


