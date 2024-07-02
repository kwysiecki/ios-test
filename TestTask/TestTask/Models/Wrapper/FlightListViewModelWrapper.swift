//
//  FlightListViewModelWrapper.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 02/07/2024.
//

import Foundation
import Combine

class FlightListViewModelWrapper: ObservableObject {
    @Published var flights: [FlightViewModel] = []
    @Published var totalCost: Double = 0.0
    @Published var viewModel:  FlightListViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: FlightListViewModel) {
        self.viewModel = viewModel
        subscribe()
    }
    
    func subscribe() {
        viewModel.flightSubject
            .sink { [weak self] in self?.flights = $0 }
            .store(in: &cancellables)
        
        viewModel.totalCostSubject
            .sink { [weak self] in self?.totalCost = $0 }
            .store(in: &cancellables)
    }
}
