//
//  FlightListViewModel.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation
import Combine

protocol Flight: Identifiable {
    var price: Double { get }
    var duration: Double { get }
}

class AirlineFlight: Flight {
    var id = UUID()
    var price: Double
    var duration: Double
    
    init(id: UUID = UUID(), price: Double, duration: Double) {
        self.id = id
        self.price = price
        self.duration = duration
    }
}

protocol FlightList {
    var flights: [AirlineFlight] { get set }
    func calcuateTotalCost() -> Double
}

class FlightListViewModel: ObservableObject, FlightList {
    @Published var flights: [AirlineFlight] = []
    @Published var totalCost: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $flights
            .sink { [weak self] flights in
                self?.totalCost = self?.calcuateTotalCost() ?? 0.0
            }
            .store(in: &cancellables)
    }
    
    func calcuateTotalCost() -> Double {
        return flights.reduce(0) { $0 + $1.price }
    }
    
    func addFlight(price: Double, duration: Double) {
        let newFlight = AirlineFlight(price: price, duration: duration)
        flights.append(newFlight)
        totalCost = calcuateTotalCost()
    }
    
    func removeFlight(at offsets: IndexSet) {
        flights.remove(atOffsets: offsets)
        totalCost = calcuateTotalCost()
    }
}
