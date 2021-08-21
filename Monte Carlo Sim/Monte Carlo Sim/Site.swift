//
//  Site.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import SwiftUI

class Site:ObservableObject, Hashable {
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
    
    public var isOpen:Bool {
        return state != .closed
    }
    
    init(row: Int, col: Int, gridModel: GridModel) {
        self.row = row
        self.col = col
        self.gridModel = gridModel
    }
    
    public func open() {
        gridModel.grid.open(row: row, col: col)
        self.state = gridModel.grid.isFull(row: row, col: col) ? .full : .open
        print(self.state)
        gridModel.percolates = gridModel.grid.percolates()
        gridModel.fillSites()
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
