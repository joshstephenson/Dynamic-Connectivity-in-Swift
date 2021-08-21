//
//  SimulationConfig.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import Foundation

class SimulationConfig: ObservableObject{
    @Published var numTrials: Int = 10
    @Published var confidenceCoefficient = 0.95
}
