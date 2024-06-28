//
//  FlightViewModel.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation

class FlightViewModel: Identifiable, ObservableObject {
    @Published var flight: Flight
    
    var id: UUID {
        return flight.id
    }
    
    var price: Double {
        return flight.price
    }
    
    var duration: Double {
        return flight.duration
    }
    
    init(flight: Flight) {
        self.flight = flight
    }
}
