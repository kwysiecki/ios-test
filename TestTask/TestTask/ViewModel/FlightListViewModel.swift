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
    
    private var cancellables: Set<AnyCancellable> = []
    private let flightsService: FlightsServiceProtocol
    
    init(flightsService: FlightsServiceProtocol) {
        self.flightsService = flightsService
        fetchFlights()
        calculateTotalCost()
    }
    
    func fetchFlights() {
        flightsService.getFlights()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] flights in
                self?.flights = flights.map { FlightViewModel(flight: $0.flight) }
            })
            .store(in: &cancellables)
    }
    
    func calculateTotalCost() {
        flightsService.calculateTotalCost()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] totalCost in
                self?.totalCost = totalCost
            })
            .store(in: &cancellables)
    }
    
    func addFlight(price: Double, duration: Double) {
        flightsService.addFlight(price: price, duration: duration)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in
                self?.fetchFlights()
                self?.calculateTotalCost()
            })
            .store(in: &cancellables)
    }
    
    func removeFlight(at offsets: IndexSet) {
        flightsService.removeFlight(at: offsets)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in
                self?.fetchFlights()
                self?.calculateTotalCost()
            })
            .store(in: &cancellables)
    }
    
    
    
    //    var flights: AnyPublisher<[FlightViewModel], Error>
    //    var totalCost: AnyPublisher<Double, Error>
    //
    //    @Published var newFlightPrice: String = ""
    //    @Published var newFlightDuration: String = ""
    //
    //    init(flightsService: FlightsService) {
    //        totalCost = Just(10.0)
    //            .flatMap { _ in
    //                flightsService.calculateTotalCost()
    //            }
    //            .eraseToAnyPublisher()
    //
    //        flights = Just([])
    //            .flatMap { _ in
    //                flightsService.getFlights()
    //            }
    //            .eraseToAnyPublisher()
    //    }
    
    //    func addFlight() {
    //        guard let price = Double(newFlightPrice), let duration = Double(newFlightDuration) else {
    //            return
    //        }
    //
    //        flightsService.addFlight(price: price, duration: duration)
    //
    //        newFlightPrice = ""
    //        newFlightDuration = ""
    //    }
    //
    //    func removeFlight(at offsets: IndexSet) {
    //        flightsService.removeFlight(at: offsets)
    //        reloadData()
    //    }
    
    //    private func reloadData() {
    //        self.flightSubject.send(flightsService.flights.map { FlightViewModel(flight: $0) })
    //        self.totalCostSubject.send(flightsService.calculateTotalCost())
    //    }
    
    //    func subscribe() {
    //        viewModel.flightSubject
    //            .sink { [weak self] in self?.flights = $0 }
    //            .store(in: &cancellables)
    //
    //        viewModel.totalCostSubject
    //            .sink { [weak self] in self?.totalCost = $0 }
    //            .store(in: &cancellables)
    //    }
}


