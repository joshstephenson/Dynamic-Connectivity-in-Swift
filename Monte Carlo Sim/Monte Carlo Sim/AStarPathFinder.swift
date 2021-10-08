//
//  AStarPathFinder.swift
//  Dynamic Connectivity
//
//  Created by Joshua Stephenson on 10/7/21.
//

import Foundation

struct SearchNode: Comparable, Equatable {
    
    var priority: Int
    var isSolved: Bool = false
    var grid: GridModel
    var path: [Site]
    var previous: Site?
    
    init(grid: GridModel, path: [Site], previous: Site?) {
        self.grid = grid
        self.path = path
        self.previous = previous
        self.priority = path.count + path.last!.row
        self.isSolved = path.last!.row == 1
    }
    
    static func < (lhs: SearchNode, rhs: SearchNode) -> Bool {
        return lhs.priority < rhs.priority
    }
    
    static func == (lhs: SearchNode, rhs: SearchNode) -> Bool {
        return lhs.priority == rhs.priority
    }
    
}

struct AStarPathFinder {
    private var path: [Site]
    
    init(grid: GridModel) {
        self.path = []
        var minPQ = MinimumPriorityQueue<SearchNode>()
        grid.rows.last?.forEach { site in
            if site.isFull {
                minPQ.insert(SearchNode(grid: grid, path: [site], previous: nil))
            }
        }
        
        while !minPQ.isEmpty() && !minPQ.min()!.isSolved {
            if let node = minPQ.delMin() {
                for site in node.grid.fullAdjascentSites(site: node.path.last!) {
                    if node.previous == nil || site != node.previous! {
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
    
    func solution() -> [Site] {
        return path
    }
}
