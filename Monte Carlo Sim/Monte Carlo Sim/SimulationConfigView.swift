//
//  SimulationConfigView.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import SwiftUI

struct TrialStepperView: View {
    @ObservedObject var config: SimulationConfig
    @State var value = 10
    var min = 5
    var max = 1000
    var step = 10
    
    func increment() {
        if value + step > max {
            return
        }
        value += step
        config.numTrials = value
    }
    
    func decrement() {
        if value - step < min {
            return
        }
        value -= step
        config.numTrials = value
    }
    
    var body: some View {
        Stepper("Trials: \(value)", onIncrement: increment, onDecrement: decrement) { changed in
            
        }
    }
}


struct ConfidenceStepperView: View {
    @ObservedObject var config: SimulationConfig
    @State var value = 95
    var max = 99
    var min = 90
    var step = 1
    
    func increment() {
        if value + step > max {
            return
        }
        value += step
        config.confidenceCoefficient = Double(value) / 100.0
    }
    
    func decrement() {
        if value - step < min {
            return
        }
        value -= 1
        config.confidenceCoefficient = Double(value) / 100.0
    }
    
    var body: some View {
        Stepper("Confidence Coefficient: \(value)", onIncrement: increment, onDecrement: decrement) { changed in
            
        }
    }
}

struct SimulationConfigView: View {
    @EnvironmentObject var simulationConfig: SimulationConfig
    var body: some View {
        VStack {
            TrialStepperView(config: simulationConfig)
            ConfidenceStepperView(config: simulationConfig)
        }
    }
}
