//
//  Simulation.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/14/21.
//

import Foundation

struct Simulation {
    private var trials: Int
    private var gridSize: Int
    private var siteCount: Int
    private var pstar: Double
    
    init(trials: Int, gridSize: Int, pstar: Double) {
        self.trials = trials
        self.gridSize = gridSize
        self.siteCount = gridSize^2
        self.pstar = 1.01 + pstar
//    }
//
//    public func run() {
        var results:[Double] = [Double](repeating: 0.0, count: trials)
        
        for _ in 1...trials {
            let p = PercolatingGrid(gridSize)
            results.append(findPercolationPoint(p: p))
//            print("Trial \(i): \(results.last!)")
        }
        // find the standard deviation
        let expression = NSExpression(forFunction: "stddev:", arguments: [NSExpression(forConstantValue: results)])
        let expression2 = NSExpression(forFunction: "average:", arguments: [NSExpression(forConstantValue: results)])
        if let standardDeviation = expression.expressionValue(with: nil, context: nil) as? Double, let mean = expression2.expressionValue(with: nil, context: nil) as? Double {
            // find the confidence interval based on the pstar
            let confidence = pstar * standardDeviation / Double(trials).squareRoot()
            
            let confidenceLo = mean - confidence
            let confidenceHigh = mean + confidence
            print("    ======================================")
            print("\tTrials: \(trials), Grid Size: \(gridSize), p*: \(pstar)")
            print("")
            print("\tMean: \(String(format: "%.3f", mean))\n\tStandard Deviation: \(String(format: "%.3f", standardDeviation))\n\t\(Int(pstar * 100))% Confidence interval: \(String(format: "%.3f", confidenceLo)) - \(String(format: "%.3f", confidenceHigh))")
        }else {
            print("Error calculating results")
        }
    }
    
    private func findPercolationPoint(p:PercolatingGrid) -> Double {
        while(!p.percolates()){
            let row = Int.random(in: 1...gridSize)
            let col = Int.random(in: 1...gridSize)
            p.open(row: row, col: col)
        }
        return Double(p.openSitesCount) / Double(siteCount)
    }
}
