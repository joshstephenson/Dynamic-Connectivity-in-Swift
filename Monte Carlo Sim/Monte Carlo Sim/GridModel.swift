//
//  GridModel.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import Foundation

enum SearchMethod:Int {
    case depthFirstSearch = 0
    case aStarSearch = 1
}

class GridModel: ObservableObject {
    let identifier = UUID()
    private var numTrials: Int = 100
    @Published var gridSize: Int = 10
    public var siteCount:Int {
        return gridSize * gridSize
    }
    private var confidenceCoefficient: Double = 0.99
    public var rows:[[Site]]
    public var grid: PercolatingGrid
    private var shortestPath:[Site] = []
    @Published var showShortestPath = false
    @Published var searchMethod:SearchMethod = .depthFirstSearch {
        didSet {
            if percolates {
                findShortestPath(searchMethod)
            }
        }
    }
    @Published var percolates: Bool = false {
        didSet {
            if percolates {
                findShortestPath(searchMethod)
            }
        }
    }
    
    init(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        self.rows = [[]]
        setSize(n: n)
    }
    
    public func setSize(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        self.rows = Array(repeating: [], count: gridSize)
        var lastRow:[Site]? = nil
        for i in 1...gridSize {
            var previousSite:Site? = nil
            var current:[Site] = []
            for j in 1...gridSize {
                let site = Site(row: i, col: j, gridModel: self)
                if let last = lastRow {
                    site.above = last[j-1]
                    last[j-1].below = site
                }
                if let previous = previousSite {
                    site.left = previousSite
                    previous.right = site
                }
                current.append(site)
                previousSite = site
            }
            rows[i-1] = current
            lastRow = current
        }
        percolates = false
    }
    
    public func reset() {
        setSize(n: gridSize)
    }
    
    // converts row and column to single dimensional index
    public func siteFor(row:Int, col:Int) -> Site? {
        return rows[row-1][col-1]
    }
    
    public func fillSites() {
        rows.forEach { row in
            row.forEach { site in
                site.updateFull()
            }
        }
    }
    
    func fullAdjascentSites(site: Site) -> [Site] {
        // optimization to avoid checking cells right/left of
        if site.row == gridSize { // last row
            if let above = site.above {
                if above.isFull {
                    return [above]
                }
            }
            return []
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
    
    private func findShortestPath(_ searchMethod: SearchMethod) {
        var path:[Site] = []
        if (searchMethod == .aStarSearch) {
            let astar = AStarPathFinder(grid: self)
            path = astar.solution()
        }else {
            path = ShortestPercolatingPath(self).path()
        }
        // reset any older shortest path
        shortestPath.forEach { site in
            site.state = .full
        }
        for site in path {
            site.state = .shortestPath
        }
        self.shortestPath = path
    }
    
}
