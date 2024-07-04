//
//  MockFlightsService.swift
//  TestTaskTests
//
//  Created by ANDRIOS Krzysztof Wysiecki on 03/07/2024.
//

import XCTest
import Combine
@testable import TestTask

class MockFlightsService: FlightsServiceProtocol {
    func getFlights() -> AnyPublisher<[FlightViewModel], Error> {
        let flights = [
            FlightViewModel(flight: Flight(price: 100, duration: 1.0)),
            FlightViewModel(flight: Flight(price: 200, duration: 2.0))
        ]
        return Just(flights)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func calculateTotalCost() -> AnyPublisher<Double, Error> {
        return Just(300.0)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func addFlight(price: Double, duration: Double) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func removeFlight(at offsets: IndexSet) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
