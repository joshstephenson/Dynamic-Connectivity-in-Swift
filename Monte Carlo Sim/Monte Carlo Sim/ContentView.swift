//
//  ContentView.swift
//  PercolationVisualizer
//
//  Created by Joshua Stephenson on 8/12/21.
//

import SwiftUI

let kGridSize = 10

class GridModel: ObservableObject {
    let identifier = UUID()
    public static var shared = GridModel(n: kGridSize)
    private var numTrials: Int = 1
    private var gridSize: Int = kGridSize
    private var pstar: Double = 0.95
    private var sites:[Site]
    var grid: PercolatingGrid
    @Published var percolates: Bool = false
    
    init(n:Int) {
        self.grid = PercolatingGrid(kGridSize)
        
        self.sites = []
        for i in 1...kGridSize {
            for j in 1...kGridSize {
                sites.append(Site(row: i, col: j))
            }
        }
    }
    
    public func reset() {
        sites.forEach { site in
            site.close()
        }
        self.grid = PercolatingGrid(kGridSize)
        percolates = false
    }
    
    // converts row and column to single dimensional index
    public func siteFor(row:Int, col:Int) -> Site? {
        var i = col;
        if (row > 1) {
            i += (row-1) * kGridSize;
        }
        i-=1
        return sites[i];
    }
    
    internal func runTrials() {
        var results:[Double] = [Double](repeating: 0.0, count: numTrials)
    
        for i in 1...numTrials {
            self.reset()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                results.append(self.findPercolationPoint())
                print("Trial \(i): \(results.last)")
            }
        }
        
        // find the standard deviation
        let expression = NSExpression(forFunction: "stddev:", arguments: [NSExpression(forConstantValue: results)])
        let expression2 = NSExpression(forFunction: "average:", arguments: [NSExpression(forConstantValue: results)])
        
        if let standardDeviation = expression.expressionValue(with: nil, context: nil) as? Double, let mean = expression2.expressionValue(with: nil, context: nil) as? Double {
            
            // find the confidence interval based on the pstar
            let confidence = pstar * standardDeviation / Double(numTrials).squareRoot()
            let confidenceLo = mean - confidence
            let confidenceHigh = mean + confidence
            
            print("    ======================================")
            print("\tTrials: \(numTrials), Grid Size: \(gridSize), p*: \(pstar)")
            print("")
            print("\tMean: \(String(format: "%.3f", mean))\n\tStandard Deviation: \(String(format: "%.3f", standardDeviation))\n\t\(Int(pstar * 100))% Confidence interval: \(String(format: "%.3f", confidenceLo)) - \(String(format: "%.3f", confidenceHigh))")
        }else {
            print("Error calculating results")
        }
    }
    
    private func findPercolationPoint() -> Double {
        while(!grid.percolates()){
            self.openRandomSite()
//            Thread.sleep(forTimeInterval: 0.01)
        }
        return Double(grid.openSitesCount) / Double(gridSize^2)
    }
    
    private func openRandomSite() {
        let row = Int.random(in: 1...self.gridSize)
        let col = Int.random(in: 1...self.gridSize)
        if let site = self.siteFor(row: row, col: col) {
            site.open()
        }
    }
    
    public func fillSites() {
        sites.forEach { site in
            if site.state == .open {
                site.updatedFull()
            }
        }
    }
    
}

enum SiteState {
    case closed
    case open
    case full
}

class Site:ObservableObject {
    let identifier = UUID()
    var row: Int
    var col: Int
    @Published internal var state:SiteState = .closed
    public var isOpen:Bool {
        return state != .closed
    }
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public func open() {
        GridModel.shared.grid.open(row: row, col: col)
        self.state = GridModel.shared.grid.isFull(row: row, col: col) ? .full : .open
        GridModel.shared.percolates = GridModel.shared.grid.percolates()
        GridModel.shared.fillSites()
    }
    
    public func close() {
        state = .closed
    }
    
    public func updatedFull() {
        if GridModel.shared.grid.isFull(row: row, col: col) {
            state = .full
        }
    }
}

struct SiteView : View {
    @ObservedObject var site: Site
    @ObservedObject var gridModel = GridModel.shared
    private var color:Color {
        switch site.state {
        case .closed:
            return Color.init(white: 0.3, opacity: 1.0)
        case .open:
            return Color.white
        case .full:
            return Color.pink
        }
    }
    var tap: some Gesture {
        TapGesture(count:1)
            .onEnded { _ in
                self.open()
            }
    }
    
    private func open() {
        site.open()
    }
    
    var body: some View {
            Rectangle()
                .fill(self.color)
                .frame(width:50, height:50, alignment: .leading)
                .gesture(tap)
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
                        if let site = gridModel.siteFor(row: i, col: j) {
                            SiteView(site: site)
                        }
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
            Button("Random Trials") {
                gridModel.runTrials()
            }
        }
        HStack {
            Text(gridModel.percolates ? "System percolates" : "System does not percolate").font(.body)
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
