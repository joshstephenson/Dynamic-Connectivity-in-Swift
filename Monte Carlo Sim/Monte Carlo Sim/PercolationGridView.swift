//
//  PercolatingGrid.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import SwiftUI

struct PercolationGridView: View {
    @ObservedObject public var gridModel:GridModel
    
    init (gridModel: GridModel) {
        self.gridModel = gridModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing:2) {
            ForEach(gridModel.rows, id: \.self) { row in
                HStack(alignment:.center, spacing:2) {
                    ForEach(row, id: \.self) { site in
                        SiteView(site: site, gridModel: gridModel)
                    }
                }
            }
        }
    }
}
