//
//  FlightListView.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI
import Combine

struct FlightListView: View {
    @ObservedObject var viewModel: FlightListViewModel
    @State private var price: String = ""
    @State private var duration: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SimpleTextView(title: L10n.pricePlaceholder, text: $price, keyboardType: .decimalPad)
                SimpleTextView(title: L10n.durationPlaceholder, text: $duration, keyboardType: .numberPad)
                
                SimpleButton(title: L10n.addButtonTitle) {
                    if let price = Double(price), let duration = Double(duration) {
                        viewModel.addFlight(price: price, duration: duration)
                        self.price = ""
                        self.duration = ""
                    }
                }
                
                List {
                    ForEach(viewModel.flights) { flight in
                        FlightRowView(viewModel: flight)
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
        let flightsService = FlightsService()
        let viewModel = FlightListViewModel(flightsService: flightsService)
        FlightListView(viewModel: viewModel)
    }
}



