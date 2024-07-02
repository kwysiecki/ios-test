//
//  FlightListView.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI
import Combine

struct FlightListView: View {
    @ObservedObject var viewModelWrapper: FlightListViewModelWrapper
    
    public init(viewModelWrapper: FlightListViewModelWrapper) {
           self.viewModelWrapper = viewModelWrapper
       }
    
    var body: some View {
        NavigationView {
            VStack {
                SimpleTextView(title: L10n.pricePlaceholder, text: $viewModelWrapper.viewModel.newFlightPrice, keyboardType: .decimalPad)
                SimpleTextView(title: L10n.durationPlaceholder, text: $viewModelWrapper.viewModel.newFlightDuration, keyboardType: .numberPad)
                
                SimpleButton(title: L10n.addButtonTitle) {
                    viewModelWrapper.viewModel.addFlight()
                }

                List {
                    ForEach(viewModelWrapper.flights) { flightViewModel in
                        FlightRowView(viewModel: flightViewModel)
                    }
                    .onDelete(perform: viewModelWrapper.viewModel.removeFlight)
                }

                Text("\(L10n.totalCostLabel) \(viewModelWrapper.totalCost, specifier: "%.2f")")
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
        let viewModelWrapper = FlightListViewModelWrapper(viewModel: viewModel)
        FlightListView(viewModelWrapper: viewModelWrapper)
    }
}
