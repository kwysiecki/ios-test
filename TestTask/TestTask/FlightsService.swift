//
//  FlightsService.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation
import Combine

protocol FlightsServiceProtocol {
    func getFlights() -> AnyPublisher<[FlightViewModel], Error>
    func calculateTotalCost() -> AnyPublisher<Double, Error>
    func addFlight(price: Double, duration: Double) -> AnyPublisher<Void, Error>
    func removeFlight(at offsets: IndexSet) -> AnyPublisher<Void, Error>
}

class FlightsService: FlightsServiceProtocol {
    
    var flights: [FlightViewModel] = []
    
    func getFlights() -> AnyPublisher<[FlightViewModel], any Error> {
        Just(flights)
            .setFailureType(to: Error.self)
            .delay(for: 2, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func calculateTotalCost() -> AnyPublisher<Double, any Error> {
        getFlights()
            .map { flights in
                return flights.reduce(0) { $0 + $1.price }
            }
            .delay(for: 3, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func addFlight(price: Double, duration: Double) -> AnyPublisher<Void, any Error> {
        let flight = FlightViewModel(flight: Flight(price: price, duration: duration))
        
        flights.append(flight)
        
        return Just(())
            .setFailureType(to: Error.self)
//            .delay(for: 2, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func removeFlight(at offsets: IndexSet) -> AnyPublisher<Void, any Error> {
        flights.remove(atOffsets: offsets)
        
        return Just(())
            .setFailureType(to: Error.self)
//            .delay(for: 2, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
}

//class FlightsServiceImpl: FlightsService {
//    var flights: [Flight] = []
//
//    func calculateTotalCost() -> Double {
//        return flights.reduce(0) { $0 + $1.price }
//    }
//    
//    func addFlight(price: Double, duration: Double) {
//        let newFlight = Flight(price: price, duration: duration)
//        flights.append(newFlight)
//    }
//    
//    func removeFlight(at offsets: IndexSet) {
//        flights.remove(atOffsets: offsets)
//    }
//}

