//
//  FlightListViewModel.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation
import Combine

class FlightListViewModel: ObservableObject {
    @Published var newFlightPrice: String = ""
    @Published var newFlightDuration: String = ""

    var flightSubject = CurrentValueSubject<[FlightViewModel], Never>([])
    var totalCostSubject = CurrentValueSubject<Double, Never>(0.0)
    
    private let flightsService: FlightsService
    
    init(flightsService: FlightsService) {
        self.flightsService = flightsService
        
        reloadData()
    }
    
    func addFlight() {
        guard let price = Double(newFlightPrice), let duration = Double(newFlightDuration) else {
            return
        }
        
        flightsService.addFlight(price: price, duration: duration)
        reloadData()
        newFlightPrice = ""
        newFlightDuration = ""
    }
    
    func removeFlight(at offsets: IndexSet) {
        flightsService.removeFlight(at: offsets)
        reloadData()
    }
    
    private func reloadData() {
        self.flightSubject.send(flightsService.flights.map { FlightViewModel(flight: $0) })
        self.totalCostSubject.send(flightsService.calculateTotalCost())
    }
}
