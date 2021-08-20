//
//  ContentView.swift
//  PercolationVisualizer
//
//  Created by Joshua Stephenson on 8/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gridModel: GridModel
    @State var promptForTrials = false
    var body: some View {
        VStack {
            HStack {
                Button("Reset Grid") {
                    gridModel.reset()
                }
                Button("Randomized Trial") {
                    gridModel.runTrials()
                }
            }
            HStack {
                Text(gridModel.percolates ? "System percolates" : "System does not percolate").font(.body)
            }
            if promptForTrials {
                
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
