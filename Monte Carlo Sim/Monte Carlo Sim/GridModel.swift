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
    private var confidenceCoefficient: Double = 0.99
    private var sites:[Site]
    public var rows:[[Site]] {
        if sites.count == 0 {
            return []
        }
        var r:[[Site]] = []
        for i in 0..<gridSize {
            r.append([])
            for j in 0..<gridSize {
                r[i].append(siteFor(row: i+1, col: j+1)!)
            }
        }
        return r
    }
    public var grid: PercolatingGrid
    @Published var percolates: Bool = false
    
    init(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        self.sites = []
        for i in 1...gridSize {
            for j in 1...gridSize {
                let site = Site(row: i, col: j, gridModel: self)
                sites.append(site)
            }
        }
    }
    
    public func setSize(n:Int) {
        self.gridSize = n
        self.grid = PercolatingGrid(n)
        
        self.sites = []
        for i in 1...gridSize {
            for j in 1...gridSize {
                let site = Site(row: i, col: j, gridModel: self)
                sites.append(site)
            }
        }
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
