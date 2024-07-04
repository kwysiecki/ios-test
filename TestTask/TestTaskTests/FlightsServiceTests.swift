//
//  FlightsServiceTests.swift
//  TestTaskTests
//
//  Created by ANDRIOS Krzysztof Wysiecki on 04/07/2024.
//

import XCTest
import Combine
@testable import TestTask

class FlightsServiceTests: XCTestCase {

    var flightsService: FlightsService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        flightsService = FlightsService()
        cancellables = []
    }

    override func tearDownWithError() throws {
        flightsService = nil
        cancellables = nil
    }

    func testGetFlights() throws {
        let expectation = self.expectation(description: "Get Flights")
        
        flightsService.getFlights()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { flights in
                    XCTAssertEqual(flights.count, 0)
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 8, handler: nil)
    }

    func testCalculateTotalCost() throws {
        let expectation = self.expectation(description: "Calculate Total Cost")
        
        flightsService.calculateTotalCost()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { totalCost in
                    XCTAssertEqual(totalCost, 0.0)
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 8, handler: nil)
    }

    func testAddFlight() throws {
        let expectation = self.expectation(description: "Add Flight")
        
        flightsService.addFlight(price: 150.0, duration: 1.5)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { })
            .store(in: &cancellables)
        
        flightsService.getFlights()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { flights in
                    XCTAssertEqual(flights.count, 1)
                    XCTAssertEqual(flights.first?.flight.price, 150.0)
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 8, handler: nil)
    }

    func testRemoveFlight() throws {
        let expectation = self.expectation(description: "Remove Flight")
        
        flightsService.addFlight(price: 150.0, duration: 1.5)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { })
            .store(in: &cancellables)
        
        flightsService.removeFlight(at: IndexSet(integer: 0))
            .sink(receiveCompletion: { _ in },
                  receiveValue: { })
            .store(in: &cancellables)
        
        flightsService.getFlights()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { flights in
                    XCTAssertEqual(flights.count, 0)
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 8, handler: nil)
    }
}
