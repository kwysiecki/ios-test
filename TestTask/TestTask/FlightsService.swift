//
//  FlightsService.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation

protocol FlightsService {
    var flights: [Flight] { get set }
    func calculateTotalCost() -> Double
    func addFlight(price: Double, duration: Double)
    func removeFlight(at offsets: IndexSet)
}

class FlightsServiceImpl: FlightsService {
    var flights: [Flight] = []

    func calculateTotalCost() -> Double {
        return flights.reduce(0) { $0 + $1.price }
    }
    
    func addFlight(price: Double, duration: Double) {
        let newFlight = Flight(price: price, duration: duration)
        flights.append(newFlight)
    }
    
    func removeFlight(at offsets: IndexSet) {
        flights.remove(atOffsets: offsets)
    }
}

