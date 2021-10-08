//
//  AStarPathFinder.swift
//  Dynamic Connectivity
//
//  Created by Joshua Stephenson on 10/7/21.
//

import Foundation

class AStarSearch: Search {
    
    init(grid: GridModel) {
        super.init(grid)
        self.marked = Array(repeating: false, count: grid.gridSize * grid.gridSize)
        var minPQ = MinimumPriorityQueue<SearchNode>()
        grid.rows.last?.forEach { site in
            if site.isFull {
                minPQ.insert(SearchNode(grid: grid, path: [site], previous: nil))
            }
        }
        
        while !minPQ.isEmpty() && !minPQ.min()!.isSolved {
            if let node = minPQ.delMin() {
                for site in node.grid.fullAdjascentSites(site: node.path.last!) {
                    if !marked[Search.siteIndexFor(grid.gridSize, site: site)] && (node.previous == nil || site != node.previous!) {
                        marked[Search.siteIndexFor(grid.gridSize, site: site)] = true
                        let newNode = SearchNode(grid: grid, path: node.path.appending(site), previous: site)
                        minPQ.insert(newNode)
                    }
                }
            }
        }
        
        if let node = minPQ.delMin() {
            self.path = node.path
        }
    }
}
