//
//  Percolation.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/13/21.
//

import Foundation

class PercolatingGrid{
    private var sites:[Bool]
    public let size:Int
    private var uf:QuickUnionFind
    public var openSitesCount:Int = 0
    
    private let virtualTopSite:Int;
    
    init(_ n:Int) {
        uf = QuickUnionFind(n*n+1)
        size = n
        sites = [Bool](repeating: false, count: n*n+1)
        virtualTopSite = 0
    }
    
    public func open(row:Int, col:Int) {
        if validate(row:row, col:col) {
            let s = siteIndexFor(row:row, col:col), site = sites[s]
            if !site { // not already open
                openSitesCount += 1
                sites[s] = true
                
                // if in first row, connect to top virtual site
                if row == 1 {
//                    let vts = uf.find(virtualTopSite)
                    uf.union(s, and: 0)
                }
                
                connectToAdjascents(site: s)
            }
        }else{
            print("invalid row+col: \(row).\(col)")
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
        if (col < size && isOpen(row:row, col:col+1)) {
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
        let bottomRow = (size-1)*size+1..<size*size+1
        for i in bottomRow {
            let site = uf.find(i)
            if site == vts {
                return true
            }
        }
        return false
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
