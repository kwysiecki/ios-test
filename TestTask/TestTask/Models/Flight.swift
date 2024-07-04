//
//  Flight.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import Foundation

//Identifiable wymog swiftUI
struct Flight: Identifiable {
    let id = UUID()
    let price: Double
    let duration: Double
}
