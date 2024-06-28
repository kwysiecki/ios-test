//
//  TestTaskApp.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI

@main
struct TestTaskApp: App {
    var body: some Scene {
        WindowGroup {
            let flightsService = FlightsServiceImpl()
            let viewModel = FlightListViewModel(flightsService: flightsService)
            FlightListView(viewModel: viewModel)
        }
    }
}
