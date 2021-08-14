//
//  Monte_Carlo_SimApp.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/13/21.
//

import SwiftUI

@main
struct Monte_Carlo_SimApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        let p = Simulation(trials: 10, gridSize: 10, pstar: 0.95)
    }
}
