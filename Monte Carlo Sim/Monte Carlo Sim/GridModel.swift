//
//  GridModel.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import Foundation


class GridModel: ObservableObject {
    let identifier = UUID()
    private var numTrials: Int = 100
    private var gridSize: Int
    private var confidenceCoefficient: Double = 0.99
    private var sites:[Site]
    public var grid: PercolatingGrid
    @Published var percolates: Bool = false
    
    init(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        
        self.sites = []
        for i in 1...gridSize {
            for j in 1...gridSize {
                let site = Site(row: i, col: j, gridModel: self)
                sites.append(site)
            }
        }
    }
    
    public func reset() {
        sites.forEach { site in
            site.close()
        }
        self.grid = PercolatingGrid(gridSize)
        percolates = false
    }
    
    // converts row and column to single dimensional index
    public func siteFor(row:Int, col:Int) -> Site? {
        var i = col;
        if (row > 1) {
            i += (row-1) * gridSize;
        }
        i-=1
        return sites[i];
    }
    
    internal func runTrials() {
        var results:[Double] = []
    
        for _ in 1...numTrials {
            self.reset()
            results.append(self.findPercolationPoint())
        }
        
        // find the standard deviation
        let expression = NSExpression(forFunction: "stddev:", arguments: [NSExpression(forConstantValue: results)])
        let expression2 = NSExpression(forFunction: "average:", arguments: [NSExpression(forConstantValue: results)])
        
        if let standardDeviation = expression.expressionValue(with: nil, context: nil) as? Double, let mean = expression2.expressionValue(with: nil, context: nil) as? Double {
            
            // find the confidence interval based on the pstar
            let confidence = confidenceCoefficient * standardDeviation / Double(numTrials).squareRoot()
            let confidenceLo = mean - confidence
            let confidenceHigh = mean + confidence
            let resultString = """
                
                \tTrials: \(numTrials), Grid Size: \(gridSize), Confidence Coefficient: \(confidenceCoefficient)

                \tMean: \t\t\t\t\t\t\(String(format: "%.3f", mean))\n\tStandard Deviation: \t\t\(String(format: "%.3f", standardDeviation))\n\t\(Int(confidenceCoefficient * 100))% Confidence interval: \t[\(String(format: "%.3f", confidenceLo)), \(String(format: "%.3f", confidenceHigh))]
                """
            print(resultString)
        }else {
            print("Error calculating results")
        }
    }
    
    private func findPercolationPoint() -> Double {
        while(!grid.percolates()){
            self.openRandomSite()
        }
        let percolationPoint = Double(grid.openSitesCount) / Double(gridSize*gridSize)
        return percolationPoint
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
            site.updateFull()
        }
    }
    
}
