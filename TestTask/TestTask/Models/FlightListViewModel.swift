//
//  FlightListViewModel.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation
import Combine

class FlightListViewModel: ObservableObject {
    @Published var flights: [FlightViewModel] = []
    @Published var totalCost: Double = 0.0
    @Published var newFlightPrice: String = ""
    @Published var newFlightDuration: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let flightsService: FlightsService
    
    init(flightsService: FlightsService) {
        self.flightsService = flightsService
        self.flights = flightsService.flights.map { FlightViewModel(flight: $0) }

        $flights
            .sink { [weak self] _ in
                self?.totalCost = flightsService.calculateTotalCost()
            }
            .store(in: &cancellables)
    }
    
    func addFlight() {
        guard let price = Double(newFlightPrice), let duration = Double(newFlightDuration) else {
            return
        }
        
        flightsService.addFlight(price: price, duration: duration)
        flights = flightsService.flights.map { FlightViewModel(flight: $0) }
        newFlightPrice = ""
        newFlightDuration = ""
    }
    
    func removeFlight(at offsets: IndexSet) {
        flightsService.removeFlight(at: offsets)
        flights = flightsService.flights.map { FlightViewModel(flight: $0) }
    }
}
