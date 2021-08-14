//
//  ContentView.swift
//  PercolationVisualizer
//
//  Created by Joshua Stephenson on 8/12/21.
//

import SwiftUI

let kGridSize = 8

class GridModel: ObservableObject {
    let identifier = UUID()
    private static var size = kGridSize
    public static var shared = GridModel(n: kGridSize)
    var grid: PercolatingGrid
    @Published var percolates: Bool = false
    @Published var needsReset: Bool = false
    
    init(n:Int) {
        self.grid = PercolatingGrid(GridModel.size)
    }
    
    public func reset() {
        needsReset = true
        self.grid = PercolatingGrid(GridModel.size)
        percolates = false
    }
}

struct SiteView : View {
    var row: Int
    var col: Int
    @State var isOpen: Bool
    @ObservedObject var gridModel = GridModel.shared
    
    var tap: some Gesture {
        TapGesture(count:1)
            .onEnded { _ in
                open()
            }
    }
    
    private func open() {
        if gridModel.grid.openSitesCount == 0 {
            gridModel.needsReset = false
        }
        isOpen = true
        GridModel.shared.grid.open(row: row, col: col)
        GridModel.shared.percolates = GridModel.shared.grid.percolates()
    }
    
    var body: some View {
        if gridModel.needsReset {
            Circle()
                .fill(Color.gray)
                .frame(width:50, height:50, alignment: .leading)
                .gesture(tap)
        }else {
            Circle()
                .fill(gridModel.grid.isOpen(row: row, col: col) ? Color.pink : Color.gray)
                .frame(width:50, height:50, alignment: .leading)
                .gesture(tap)
        }
    }
    
}

struct PercolationGrid: View {
    @ObservedObject public var gridModel:GridModel
    @State private var n:Int
    
    init (gridModel: GridModel) {
        self.gridModel = gridModel
        self.n = gridModel.grid.size
    }
    var body: some View {
        VStack(alignment: .leading, spacing:5) {
            ForEach(1..<n+1) { i in
                HStack(alignment:.center, spacing:5) {
                    ForEach(1..<n+1) { j in
                        SiteView(row: i, col: j, isOpen: gridModel.grid.isOpen(row: i, col: j))
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    @ObservedObject var gridModel = GridModel.shared
    var body: some View {
        Spacer()
        HStack {
            Button("Reset") {
                GridModel.shared.reset()
            }
            Text(gridModel.percolates ? "System percolates." : "System does not percolate.").font(.title)
        }
        PercolationGrid(gridModel: gridModel)
        Spacer()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        ContentView(gridModel: GridModel(n:10))
//    }
//}
