//
//  FlightListView.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI

struct FlightListView: View {
    @ObservedObject var viewModel: FlightListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SimpleTextView(title: L10n.pricePlaceholder, text: $viewModel.newFlightPrice, keyboardType: .decimalPad)
                SimpleTextView(title: L10n.durationPlaceholder, text: $viewModel.newFlightDuration, keyboardType: .numberPad)
                
                SimpleButton(title: L10n.addButtonTitle) {
                    viewModel.addFlight()
                }

                List {
                    ForEach(viewModel.flights) { flightViewModel in
                        FlightRowView(viewModel: flightViewModel)
                    }
                    .onDelete(perform: viewModel.removeFlight)
                }

                Text("\(L10n.totalCostLabel) \(viewModel.totalCost, specifier: "%.2f")")
                    .font(.headline)
                    .padding()
            }
            .navigationBarTitle(L10n.flightsTitle)
        }
    }
}

struct FlightListView_Previews: PreviewProvider {
    static var previews: some View {
        let flightsService = FlightsServiceImpl()
        let viewModel = FlightListViewModel(flightsService: flightsService)
        FlightListView(viewModel: viewModel)
    }
}
