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
            
        }
    }
}

struct ContentView: View {
    @ObservedObject var gridModel: GridModel
    @State var gridSize = 5
    @EnvironmentObject var simulationConfig: SimulationConfig
    var simulator = Simulator()
    var body: some View {
        HStack(alignment: .top, spacing: 10.0, content: {
            VStack(alignment: .center, spacing: 10.0, content: {
                GridSizeStepperView(gridModel: gridModel)
                Button("Reset Grid") {
                    gridModel.reset()
                }
            }).frame(minWidth: 200.0, idealWidth: 200.0, maxWidth: nil, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .topLeading)
            VStack(alignment: .leading, spacing: 10.0, content: {
                SimulationConfigView()
                Button("Run") {
                    simulator.run(config: simulationConfig, gridModel: gridModel)
                }
            })
        }).padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
        
        VStack {
            
            HStack {
                Text(gridModel.percolates ? "System percolates" : "System does not percolate").font(.body)
            }
            PercolationGridView(gridModel: gridModel)
        }.padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        ContentView(gridModel: GridModel(n:10))
//    }
//}
