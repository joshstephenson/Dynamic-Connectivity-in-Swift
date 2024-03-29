//
//  DepthFirstSearch.swift
//  Dynamic Connectivity
//
//  Created by Joshua Stephenson on 10/8/21.
//

import Foundation

class DepthFirstSearch: Search {
    override init(_ grid: GridModel) {
        super.init(grid)
        var queue:[SearchNode] = []
        
        for site in grid.rows.last! {
            queue.append(SearchNode(grid: grid, path: [site], previous: nil))
            marked[BreadthFirstSearch.siteIndexFor(grid.gridSize, site: site)] = true
        }
        
        while !queue.isEmpty && !queue.last!.isSolved {
            let node = queue.removeLast()
            let lastSite = node.path.last!
            for site in node.grid.fullAdjascentSites(site: lastSite) {
                if !marked[Search.siteIndexFor(grid.gridSize, site: site)] && (node.previous == nil || site != node.previous )  {
                    marked[Search.siteIndexFor(grid.gridSize, site: site)] = true
                    queue.append(SearchNode(grid: grid, path: node.path.appending(site), previous: lastSite))
                }
            }
        }
        let node = queue.removeLast()
        if node.isSolved {
            self.path = node.path
            return
        }
    
        self.path = []
    }
    
}
