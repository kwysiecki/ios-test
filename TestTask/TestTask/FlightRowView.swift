//
//  FlightRowView.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI

struct FlightRowView: View {
    @ObservedObject var viewModel: FlightViewModel
    
    var body: some View {
        HStack {
            Text("\(L10n.pricePlaceholder): \(viewModel.price, specifier: "%.2f")")
            Spacer()
            Text("\(L10n.durationPlaceholder): \(viewModel.duration, specifier: "%.2f") min")
        }
    }
}
