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
        if path.last?.row == 1 { // once we reached the top row, we're done
            return path
        }
        let current = path.last!
        var best:[Site] = []

        // We can check as many as three adjascent sites
        // and need to follow all options
        fullAdjascentSites(site: current).forEach({ adjascent in
            let index = siteIndexFor(adjascent)
            if !marked[index] {
                marked[index] = true
                let updated = run(path.appending(adjascent))
                best = shorterCompletePath(best: best, updated: updated)
            }
        })
        
        return best
    }
    
    private func shorterCompletePath(best: [Site], updated: [Site]) -> [Site] {
        if updated.last?.row == 1 {
            if best.count == 0 || updated.count < best.count {
                return updated
            }
        }
        return best
    }
    
    private func fullAdjascentSites(site: Site) -> [Site] {
        // optimization to avoid checking cells right/left of
        if site.row == gridModel.gridSize { // last row
            if let above = site.above {
                return [above]
            }else {
                return []
            }
        }
        return [site.above, site.left, site.right, site.below].compactMap { site in
            if let site = site {
                if site.isFull {
                    return site
                }
            }
            return nil
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

extension Array where Element: Any {
    func appending(_ other: Element) -> Array<Element> {
        var arr:Array<Element> = self
        arr.append(other)
        return arr
    }
}
