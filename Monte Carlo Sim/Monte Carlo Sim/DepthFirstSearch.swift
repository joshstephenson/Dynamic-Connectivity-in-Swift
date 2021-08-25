//
//  DepthFirstSearch.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/25/21.
//

import Foundation

class DepthFirstSearch {
    private var gridModel: GridModel
    private var grid:PercolatingGrid {
        return gridModel.grid
    }
    private var marked:[Bool]
    
    init(_ gridModel: GridModel) {
        self.gridModel = gridModel
        marked = Array(repeating: false, count: gridModel.siteCount)
    }
    
    public func run(_ path:[Site]) -> [Site] {
        if path.last!.row == 1 { // once we reached the top row, we're done
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
            return run(newPath)
            
        // If we reach a dead end before the top, back out of this one by one up the call chain
        }else if path.last!.row > 1{
            newPath.removeLast()
            if newPath.count > 0 {
                return run(newPath)
            }
        }
        return path
    }
    
    // Don't return left/right sites for bottom row
    // those are already accounted for by loop over bottom row from ShortestPercolatingPath
    private func adjascentByIndex(site: Site, index: Int) -> Site? {
        switch index {
        case 4:
            return site.above
        case 3:
            if site.row == gridModel.gridSize {
                return nil
            }
            return site.left
        case 2:
            if site.row == gridModel.gridSize {
                return nil
            }
            return site.right
        default:
            if site.row == gridModel.gridSize {
                return nil
            }
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
