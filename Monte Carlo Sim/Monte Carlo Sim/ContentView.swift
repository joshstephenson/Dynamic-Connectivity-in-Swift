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
    var didChangeHandler:(() -> Void)
    init(gridModel: GridModel, _ didChange: @escaping () -> Void) {
        self.gridModel = gridModel
        didChangeHandler = didChange
    }
    
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
            didChangeHandler()
        }
    }
}

struct ContentView: View {
    @ObservedObject var gridModel: GridModel
    @EnvironmentObject var simulationConfig: SimulationConfig
    @State var threshold = 0.0
    var simulator = Simulator()
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack(alignment: .top, spacing: 90.0, content: {
                HStack(alignment: .top, spacing: 10.0) {
                    GridSizeStepperView(gridModel: gridModel) {
                        self.threshold = 0.0
                    }
                    Toggle("Highlight shortest path", isOn: $gridModel.showShortestPath)
                }
                HStack(alignment: .top, spacing: 20.0) {
                    Button(gridModel.aStarSearch ? "DFS Search" : "A* Search") {
                        gridModel.aStarSearch = !gridModel.aStarSearch
                    }
                    Button("Reset") {
                        threshold = 0.0
                        gridModel.reset()
                    }

                    Button("Randomize") {
                        threshold = simulator.run(config: simulationConfig, gridModel: gridModel)
                    }
                }
            })
            
            VStack(alignment: .center, spacing: nil) {
                
                    if threshold > 0.0 {
                        let openSites = Int((threshold * Double(gridModel.siteCount)).rounded(.up))
                        Text("Percolation threshold: \(openSites)/\(gridModel.siteCount) (\(Int((threshold * 100).rounded(.up)))%)")
                    }else {
                        Text(gridModel.percolates ? "System percolates" : "System does not percolate").font(.body)
                    }
                
            }.frame(width: 600, height: 10, alignment: .center)
            PercolationGridView(gridModel: gridModel)
        }.padding(EdgeInsets(top: 20.0, leading: 10.0, bottom: 20.0, trailing: 10.0))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        ContentView(gridModel: GridModel(n:10))
//    }
//}
