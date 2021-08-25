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
        let bottom = gridModel.rows.last!.first!
        let path:[Site] = findNext([bottom])
        return path
    }
    
    private func findNext(_ path:[Site]) -> [Site] {
        if path.last?.row == 1 { // once we reached the top row, we're done
            return path
        }
        let current = path.last!
        var newPath = path
        var newSite:Site?
        var count = 4
        // check 4 adjascent sites to see if
        //   a: they haven't been marked and
        //   b: they are full
        while count > 0 {
            if let site = adjascentByIndex(site: current, index: count) {
                let index = siteIndexFor(site)
                if !marked[index] {
                    if site.isFull {
                        if newSite == nil {
                            newSite = site
                            marked[index] = true
                        }
                    }
                }
                // prune sites if they didn't get us closer to this site
                if marked[index] && path.contains(site){
                    if let i = path.lastIndex(of: site) {
                        if i < newPath.count-2 {
                            while newPath.count > i+1 {
                                newPath.removeLast()
                            }
                            newPath.append(current)
                        }
                    }
                }
            }
            count -= 1
        }
        if let next = newSite {
            newPath.append(next)
            return findNext(newPath)
        }else if path.last!.row > 1{ // dead end without path to top
            newPath.removeLast()
            if newPath.count > 0 {
                return findNext(newPath)
            
            }else if current.row == grid.size {
                if let right = current.right {
                    return findNext([right])
                }
            }
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
        var i = site.col-1;
        if (site.row > 1) {
            i += (site.row-1) * grid.size;
        }
        return i;
    }
}
