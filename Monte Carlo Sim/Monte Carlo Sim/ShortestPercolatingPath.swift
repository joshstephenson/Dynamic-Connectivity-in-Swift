//
//  ShortestPercolatingPath.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/23/21.
//

import Foundation

class ShortestPercolatingPath {
    private var gridModel: GridModel
    private var depthFirst = true
    private var grid:PercolatingGrid {
        return gridModel.grid
    }
    
    init(_ gridModel: GridModel, depthFirst: Bool) {
        self.depthFirst = depthFirst
        self.gridModel = gridModel
    }
    
    func path() -> [Site] {
        return findSolution()
    }
    
    private func findSolution() -> [Site] {
        if !grid.percolates() {
            return []
        }
        var best:[Site] = []
        // start a depth first search towards the top from each full site on the bottom
        
        let search:Search = depthFirst ? DepthFirstSearch(gridModel) : BreadthFirstSearch(gridModel)
        best = search.solution()
        return best
    }
    
   
}
