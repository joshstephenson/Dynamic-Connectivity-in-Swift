//
//  PercolatingGrid.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import SwiftUI

struct PercolationGridView: View {
    @ObservedObject public var gridModel:GridModel
    @State private var n:Int
    
    init (gridModel: GridModel) {
        self.gridModel = gridModel
        self.n = gridModel.grid.size
    }
    var body: some View {
        VStack(alignment: .leading, spacing:5) {
            ForEach(1..<n+1) { i in
                HStack(alignment:.center, spacing:5) {
                    ForEach(1..<n+1) { j in
                        if let site = gridModel.siteFor(row: i, col: j) {
                            SiteView(site: site, gridModel: gridModel)
                        }
                    }
                }
            }
        }
    }
}
