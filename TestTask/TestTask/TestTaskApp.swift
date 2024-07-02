//
//  TestTaskApp.swift
//  TestTask
//
//  Created by ANDRIOS Krzysztof Wysiecki on 28/06/2024.
//

import SwiftUI

@main
struct TestTaskApp: App {
    
    let conatainer = FlightListViewContainer()
    
    var body: some Scene {
        WindowGroup {
            conatainer.makeFlightListView()
        }
    }
}
