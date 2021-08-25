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
        print(gridModel.rows.count)
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
        print(current)
        while count > 0 {
            if let site = adjascentByIndex(site: current, index: count) {
                let index = siteIndexFor(site)
//                print("---\(site), marked \(marked[index]), isfull: \(site.isFull)")
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
//                        let dupe = path[i]
//                        print("---adjascent: \(dupe), index \(i) vs \(path.count)")
                        if i < newPath.count-2 {
                            while newPath.count > i+1 {
                                print("pruning \(newPath.last)")
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
            return findNext(hopCount: hopCount+1, path: newPath)
        }else if path.last!.row > 1{ // dead end without path to top
            newPath.removeLast()
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
        var i = site.col-1;
        if (site.row > 1) {
            i += (site.row-1) * grid.size;
        }
        return i;
    }
}
