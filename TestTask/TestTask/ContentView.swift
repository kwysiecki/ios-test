//
//  ContentView.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = FlightListViewModel()
    @State private var newFlightPrice: String = ""
    @State private var newFlightDuration: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Price (PLN)", text: $newFlightPrice)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Duration (min)", text: $newFlightDuration)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if let price = Double(newFlightPrice), let duration = TimeInterval(newFlightDuration) {
                        viewModel.addFlight(price: price, duration: duration)
                        newFlightPrice = ""
                        newFlightDuration = ""
                    }
                }) {
                    Text("Add Flight")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                List {
                    ForEach(viewModel.flights) { flight in
                        HStack {
                            Text("Price: \(flight.price, specifier: "%.2f") PLN")
                            Spacer()
                            Text("Duration: \(flight.duration, specifier: "%.2f") min")
                        }
                    }
                    .onDelete(perform: viewModel.removeFlight)
                }
                
                Text("Total Cost: \(viewModel.totalCost, specifier: "%.2f") PLN")
                    .font(.headline)
                    .padding()
            }
            .navigationBarTitle("Flights")
        }
    }
}

#Preview {
    ContentView()
}
