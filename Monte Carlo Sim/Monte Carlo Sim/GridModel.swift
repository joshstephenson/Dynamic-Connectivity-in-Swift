//
//  GridModel.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import Foundation


class GridModel: ObservableObject {
    let identifier = UUID()
    private var numTrials: Int = 100
    @Published var gridSize: Int = 10
    public var siteCount:Int {
        return gridSize * gridSize
    }
    private var confidenceCoefficient: Double = 0.99
    private var sites:[Site]
    public var rows:[[Site]]
    public var grid: PercolatingGrid
    @Published var percolates: Bool = false
    
    init(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        self.sites = []
        self.rows = [[]]
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
                sites.append(site)
                current.append(site)
                previousSite = site
            }
            rows.append(current)
            lastRow = current
        }
    }
    
    public func setSize(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        self.sites = []
        self.rows = [[]]
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
                sites.append(site)
                current.append(site)
                previousSite = site
            }
            rows.append(current)
            lastRow = current
        }
        percolates = false
    }
    
    public func reset() {
        sites.forEach { site in
            site.close()
        }
        self.grid = PercolatingGrid(gridSize)
        percolates = false
    }
    
    // converts row and column to single dimensional index
    public func siteFor(row:Int, col:Int) -> Site? {
        var i = col;
        if (row > 1) {
            i += (row-1) * gridSize;
        }
        i -= 1
        return sites[i];
    }
    
    public func fillSites() {
        sites.forEach { site in
            site.updateFull()
        }
    }
    
}
