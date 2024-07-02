//
//  FlightListViewContainer.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 02/07/2024.
//

import Foundation

class FlightListViewContainer {
    let flightsService: FlightsService
    
    init() {
        self.flightsService = FlightsServiceImpl()
    }
    
    func makeFlightListViewModel() -> FlightListViewModel {
        return FlightListViewModel(flightsService: flightsService)
    }
    
    func makeFlightListView() -> FlightListView {
        let viewModel = makeFlightListViewModel()
        let viewModelWrapper = FlightListViewModelWrapper(viewModel: viewModel)
        return FlightListView(viewModelWrapper: viewModelWrapper)
    }
}
