//
//  Site.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import SwiftUI

class Site:ObservableObject, Hashable, CustomStringConvertible {
    static func == (lhs: Site, rhs: Site) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    var gridModel: GridModel
    let identifier = UUID()
    var row: Int
    var col: Int
    @Published internal var state:SiteState = .closed
    public var left:Site?
    public var right:Site?
    public var above:Site?
    public var below:Site?
    
    var description: String {
        return "<Site row: \(row), col: \(col), state: \(state)>"
    }
    
    public var isOpen:Bool {
        return state != .closed
    }
    
    public var isFull:Bool {
        return state == .full || state == .shortestPath
    }
    
    init(row: Int, col: Int, gridModel: GridModel) {
        self.row = row
        self.col = col
        self.gridModel = gridModel
    }
    
    public func open() {
        gridModel.grid.open(row: row, col: col)
        self.state = gridModel.grid.isFull(row: row, col: col) ? .full : .open
        
        // Must call fillSites before checking percolation for Depth First Search
        gridModel.fillSites()
        gridModel.percolates = gridModel.grid.percolates()
    }
    
    public func close() {
        state = .closed
    }
    
    public func updateFull() {
        if state == .open && gridModel.grid.isFull(row: row, col: col) {
            state = .full
        }
    }
}
