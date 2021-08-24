//
//  ShortestPercolatingPath.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/23/21.
//

import Foundation

class Path {
    var from: Site
    var to: Site
    var gridModel: GridModel
    var hopCount: Int = -1
    var grid: PercolatingGrid {
        return gridModel.grid
    }
    
    init(from: Site, to: Site, gridModel: GridModel){
        self.from = from
        self.to = to
        self.gridModel = gridModel
    }
    
    public func findBest() {
        if to.state != .full {
            return
        }
    }
    
    
}

class ShortestPercolatingPath {
    private var gridModel: GridModel
    private var grid:PercolatingGrid {
        return gridModel.grid
    }
    private var marked:[Bool]
    
    init(_ gridModel: GridModel) {
        self.gridModel = gridModel
        marked = Array(repeating: false, count: gridModel.siteCount)
    }
    
    func path() -> [Site] {
        return findSolution()
    }
    
    private func findSolution() -> [Site] {
        if !grid.percolates() {
            return []
        }
        var best:[Site] = []
        var bestCount = Int.max
        let bottom = gridModel.siteFor(row: gridModel.gridSize, col: 1)
        
        // find path from here to 0,0
        gridModel.rows.last!.forEach { bottom in
            if bottom.isFull {
                let path:[Site] = findNext(hopCount: 1, path: [bottom])
                if path.count < bestCount {
                    best = path
                    bestCount = path.count
                }
            }
        }
        return best
    }
    
    private func findNext(hopCount: Int, path:[Site]) -> [Site] {
        if path.last?.row == 1 { // once we reached the top row, we're done
            return path
        }
        let current = path.last!
        var newPath = path
        var newSite:Site?
        var count = 4
        // check as many as 4 adjascent sites to see if a: they haven't been marked and
        // b: they are full
        while newSite == nil && count > 0 {
            if let site = adjascentByIndex(site: current, index: count) {
                let index = siteIndexFor(site)
                if !marked[index] {
                    marked[index] = true
                    if site.isFull {
                        newSite = site
                    }
                }
            }
            count -= 1
        }
        if let next = newSite {
            newPath.append(next)
        }
        if newPath.count > path.count {
            return findNext(hopCount: hopCount+1, path: newPath)
        }
        return path
    }
    
    private func adjascentByIndex(site: Site, index: Int) -> Site? {
        switch index {
        case 4:
            return site.above
        case 3:
            return site.left
        case 2:
            return site.right
        default:
            return site.below
        }
    }
    
    private func siteIndexFor(_ site:Site) -> Int {
        var i = site.col;
        if (site.row > 1) {
            i += (site.row-1) * grid.size;
        }
        return i;
    }
}
