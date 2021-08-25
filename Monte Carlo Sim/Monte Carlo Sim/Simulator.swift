//
//  Simulation.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/14/21.
//

import Foundation

struct Simulator {

    public func run(config: SimulationConfig, gridModel: GridModel) -> Double {
        let numTrials = config.numTrials
        let gridSize = gridModel.gridSize
        let confidence = 1.01 + config.confidenceCoefficient
        let gridModel = gridModel
        
        var results:[Double] = []
        
        for _ in 1...numTrials {
            gridModel.reset()
            results.append(self.findPercolationPoint(gridModel))
        }
        
        // find the standard deviation
        let expression = NSExpression(forFunction: "stddev:", arguments: [NSExpression(forConstantValue: results)])
        let expression2 = NSExpression(forFunction: "average:", arguments: [NSExpression(forConstantValue: results)])
        
        if let standardDeviation = expression.expressionValue(with: nil, context: nil) as? Double, let mean = expression2.expressionValue(with: nil, context: nil) as? Double {
            
            // find the confidence interval based on the pstar
            let margin = confidence * standardDeviation / Double(numTrials).squareRoot()
            let confidenceLo = mean - margin
            let confidenceHigh = mean + margin
            let resultString = """
                
                \tTrials: \(results.count), Grid Size: \(gridSize)

                \tMean: \t\t\t\t\t\t\(String(format: "%.3f", mean))\n\tStandard Deviation: \t\t\(String(format: "%.3f", standardDeviation))\n\t\(Int(config.confidenceCoefficient * 100))% Confidence interval: \t[\(String(format: "%.3f", confidenceLo)), \(String(format: "%.3f", confidenceHigh))]
                """
            print(resultString)
            
            return mean
        }else {
            print("Error calculating results")
        }
        return 0.0
    }
    
    private func findPercolationPoint(_ gridModel: GridModel) -> Double {
        let gridSize = gridModel.grid.size
        
        while(!gridModel.grid.percolates()){
            self.openRandomSite(gridModel)
        }
        gridModel.percolates = true
        let percolationPoint = Double(gridModel.grid.openSitesCount) / Double(gridSize*gridSize)
        return percolationPoint
    }
    
    private func openRandomSite(_ gridModel: GridModel) {
        let row = Int.random(in: 1...gridModel.grid.size)
        let col = Int.random(in: 1...gridModel.grid.size)
        if let site = gridModel.siteFor(row: row, col: col) {
            site.open()
        }
    }
    
    
}
