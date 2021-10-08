//
//  BreadthFirstSearch.swift
//  Dynamic Connectivity
//
//  Created by Joshua Stephenson on 10/8/21.
//

import Foundation

class BreadthFirstSearch: Search {
    override init(_ grid: GridModel) {
        super.init(grid)
        var stack:[SearchNode] = []
        
        for site in grid.rows.last! {
            stack.append(SearchNode(grid: grid, path: [site], previous: nil))
            marked[BreadthFirstSearch.siteIndexFor(grid.gridSize, site: site)] = true
        }
        
        while !stack.isEmpty && !stack.first!.isSolved {
            let node = stack.removeFirst()
            let lastSite = node.path.last!
            for site in node.grid.fullAdjascentSites(site: lastSite) {
                if !marked[Search.siteIndexFor(grid.gridSize, site: site)] && (node.previous == nil || site != node.previous )  {
                    marked[Search.siteIndexFor(grid.gridSize, site: site)] = true
                    stack.append(SearchNode(grid: grid, path: node.path.appending(site), previous: lastSite))
                }
            }
        }
        let node = stack.removeFirst()
        if node.isSolved {
            self.path = node.path
            return
        }
    
        self.path = []
    }
    
}



