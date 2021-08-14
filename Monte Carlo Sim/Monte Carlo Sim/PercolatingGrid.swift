//
//  Percolation.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/13/21.
//

import Foundation

class PercolatingGrid {
    private var sites:[Bool]
    public let size:Int
    private var uf:QuickUnionFind
    private var openSitesCount:Int = 0
    
    private let virtualTopSite:Int;
    private let virtualBottomSite:Int;
    
    init(_ n:Int) {
        uf = QuickUnionFind(n*n+2)
        size = n
        sites = [Bool](repeating: false, count: n*n+2)
        virtualTopSite = 0
        virtualBottomSite = n*n+1
    }
    
    public func open(row:Int, col:Int) {
        if validate(row:row, col:col) {
            let s = siteIndexFor(row:row, col:col), site = sites[s]
            if !site { // not already open
                openSitesCount += 1
                sites[s] = true
                
                // if in first row, connect to virtual top site
                if (row == 1) {
                    let vts = uf.find(virtualTopSite)
                    uf.union(s, and: vts)
                }
                // if in last row, connect to virtual bottom site
                if (row == size) {
                    let vbs = uf.find(virtualBottomSite)
                    uf.union(s, and: vbs)
                }
                
                connectToAdjascents(site: s)
            }else {
                print("invalid")
            }
        }
    }
    
    public func isOpen(row:Int, col:Int) -> Bool {
        let s = siteIndexFor(row:row, col:col)
        return sites[s]
    }
    
    public func isFull(row:Int, col:Int) -> Bool {
        let index = siteIndexFor(row: row, col: col)
        let site = uf.find(index)
        let vts = uf.find(virtualTopSite)
        return site == vts
    }
    
    private func connectToAdjascents(site:Int) {
        let s = site - 1;
        let row:Int = s / size + 1;
        let col:Int = s % size + 1;
        
        // look for site to the left
        if (col > 1 && isOpen(row:row, col:col-1)) {
            let left = siteIndexFor(row:row, col:col-1)
            uf.union(site, and: left)
        }
        
        // look for site to the right
        if (col > 1 && isOpen(row:row, col:col+1)) {
            let right = siteIndexFor(row:row, col:col+1)
            uf.union(site, and: right)
        }
        
        // look for site above
        if (row > 1 && isOpen(row:row-1, col:col)) {
            let above = siteIndexFor(row:row-1, col:col)
            uf.union(site, and: above)
        }
        
        // look for site below
        if (row < size && isOpen(row: row+1, col: col)) {
            let below = siteIndexFor(row: row+1, col: col)
            uf.union(site, and: below)
        }
    }
    
    public func percolates() -> Bool {
        let vts = uf.find(virtualTopSite)
        let vbs = uf.find(virtualBottomSite)
        return vts == vbs
    }
    
    // converts row and column to single dimensional index
    private func siteIndexFor(row:Int, col:Int) -> Int {
        var i = col;
        if (row > 1) {
            i += (row-1) * size;
        }
        return i;
    }
    
    private func validate(row:Int, col:Int) -> Bool {
        if (row <= 0 || row > size) {
            return false
        }
        if (col <= 0 || col > size) {
            return false
        }
        return true
    }
}
