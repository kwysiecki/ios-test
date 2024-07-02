//
//  MockFlightsService.swift
//  TestTaskTests
//
//  Created by ANDRIOS Krzysztof Wysiecki on 03/07/2024.
//

import XCTest
@testable import TestTask

class MockFlightsService: FlightsService {
    var flights: [Flight] = []
    
    func calculateTotalCost() -> Double {
        return flights.reduce(0) { $0 + $1.price }
    }
    
    func addFlight(price: Double, duration: TimeInterval) {
        let newFlight = Flight(price: price, duration: duration)
        flights.append(newFlight)
    }
    
    func removeFlight(at offsets: IndexSet) {
        flights.remove(atOffsets: offsets)
    }
}
