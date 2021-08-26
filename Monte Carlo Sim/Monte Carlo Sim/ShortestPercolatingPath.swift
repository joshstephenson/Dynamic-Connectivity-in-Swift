//
//  ShortestPercolatingPath.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/23/21.
//

import Foundation

class ShortestPercolatingPath {
    private var gridModel: GridModel
    private var grid:PercolatingGrid {
        return gridModel.grid
    }
    
    init(_ gridModel: GridModel) {
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
        gridModel.rows.last?.forEach { site in
            if grid.isFull(row: site.row, col: site.col) {
                let dfs = DepthFirstSearch(gridModel)
                let path = dfs.run([site])
                
                // make sure the search reaches the top
                if path.last?.row == 1 {
                    if best.count == 0 || path.count < best.count {
                        best = path
                    }
                }
                
            }
        }
        return best
    }
    
   
}
