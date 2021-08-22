//
//  ContentView.swift
//  PercolationVisualizer
//
//  Created by Joshua Stephenson on 8/12/21.
//

import SwiftUI

struct GridSizeStepperView: View {
    @ObservedObject var gridModel: GridModel
    @State var value = 10
    var min = 3
    var max = 25
    
    func increment() {
        if value == max {
            return
        }
        value += 1
        gridModel.setSize(n: value)
    }
    
    func decrement() {
        if value == min {
            return
        }
        value -= 1
        gridModel.setSize(n: value)
    }
    
    var body: some View {
        Stepper("Grid Size: \(value)", onIncrement: increment, onDecrement: decrement) { changed in
            
        }.font(.headline)
    }
}

struct ContentView: View {
    @ObservedObject var gridModel: GridModel
    @EnvironmentObject var simulationConfig: SimulationConfig
    @State var probability = 0
    var simulator = Simulator()
    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            HStack(alignment: .top, spacing: 40.0) {
                VStack (alignment: .leading, spacing: 20.0) {
                    GridSizeStepperView(gridModel: gridModel)
                
                    Button("Reset Grid") {
                        probability = 0
                        gridModel.reset()
                    }
                }
                VStack(alignment: .leading, spacing: 10.0) {
                    TrialStepperView(config: simulationConfig)
                    ConfidenceStepperView(config: simulationConfig)
                    Button("Run") {
                        probability = simulator.run(config: simulationConfig, gridModel: gridModel)
                    }
                }
            }
            HStack {
                if probability > 0 {
                    Text("Percolation threshold: \(probability)/\(gridModel.gridSize*gridModel.gridSize) sites")
                }else {
                    Text(gridModel.percolates ? "System percolates" : "System does not percolate").font(.body)
                }
            }
            PercolationGridView(gridModel: gridModel)
        }.padding(EdgeInsets(top: 20.0, leading: 10.0, bottom: 20.0, trailing: 10.0))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        ContentView(gridModel: GridModel(n:10))
//    }
//}
