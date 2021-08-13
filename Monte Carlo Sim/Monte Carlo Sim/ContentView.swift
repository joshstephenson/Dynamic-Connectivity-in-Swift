//
//  ContentView.swift
//  PercolationVisualizer
//
//  Created by Joshua Stephenson on 8/12/21.
//

import SwiftUI
import Combine

class GridModel: ObservableObject {
    @Published var n: Int = 5
    @Published var grid: PercolatingGrid
    internal var rows: [Row]
    
    init(n:Int) {
        self.n = n
        self.grid = PercolatingGrid(n)
        var r = [Row]()
        for _ in 1...n {
            var cols = [Bool]()
            for _ in 1...n {
                cols.append(false)
            }
            r.append(Row(cols))
        }
//        let rows = [Row([false, false, false, false]),
//                    Row([false, false, false, false]),
//                    Row([false, false, false, false]),
//                    Row([false, false, false, false])
//                    ]
        self.rows = r
    }
    
}

class Row: Identifiable{
    let id = UUID()
    var cols:[Bool] = []
    
    init(_ c: [Bool]) {
        cols = c
    }
}

struct SiteView : View {
    var row: Int
    var col: Int
    @State private var isOpen = false
    
    var tap: some Gesture {
        TapGesture(count:1)
            .onEnded { _ in
                open()
            }
    }
    
    private func open() {
        isOpen = true
        Monte_Carlo_SimApp.gridModel.grid.open(row: row, col: col)
        print(Monte_Carlo_SimApp.gridModel.grid.percolates())
    }
    
    var body: some View {
        Circle()
            .fill(isOpen ? Color.pink : Color.gray)
            .frame(width:50, height:50, alignment: .leading)
            .gesture(tap)
    }
    
}

struct PercolationGrid: View {
    public var n:Int
    var body: some View {
        VStack {
            ForEach(1..<n+1) { i in
                HStack {
                    ForEach(1..<n+1) { j in
                        SiteView(row: i, col: j)
                    }
                }
            }
        }
//        List(rows) { row in
//            ForEach(row.cols, id: \.self) { col in
//                SiteView(isFull: col)
//            }
//        }
    }
}


struct ContentView: View {
    var body: some View {
        PercolationGrid(n:Monte_Carlo_SimApp.gridModel.grid.size)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
