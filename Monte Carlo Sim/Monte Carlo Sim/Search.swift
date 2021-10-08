//
//  Search.swift
//  Dynamic Connectivity
//
//  Created by Joshua Stephenson on 10/8/21.
//

import Foundation

struct SearchNode: Comparable, Equatable, CustomStringConvertible {
    
    var priority: Int
    var isSolved: Bool = false
    var grid: GridModel
    var path: [Site]
    var previous: Site?
    
    public var description: String {
        return "(SearchNode| last: \(path.last!), priority: \(priority)"
    }
    
    init(grid: GridModel, path: [Site], previous: Site?) {
        self.grid = grid
        self.path = path
        self.previous = previous
        
        /// priority here is number of items in our path so far PLUS
        /// the row of our last site, which means those nearer the top will have a lower priority
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

class Search {
    var path: [Site] = []
    var marked: [Bool]
    
    init(_ grid: GridModel) {
        self.marked = Array(repeating: false, count: grid.gridSize * grid.gridSize)
    }
    
    static func siteIndexFor(_ gridSize: Int, site:Site) -> Int {
        var i = site.col-1;
        if (site.row > 1) {
            i += (site.row-1) * gridSize;
        }
        return i;
    }
    
    func solution() -> [Site] {
        return self.path
    }
}
