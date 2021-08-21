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
        VStack(alignment: .leading, spacing:5) {
//            ForEach(1..<gridModel.gridSize+1) { i in
                
                ForEach(gridModel.rows, id: \.self) { row in
                    HStack(alignment:.center, spacing:5) {
                        ForEach(row, id: \.self) { site in
                            SiteView(site: site, gridModel: gridModel)
                        }
                    }
                }
//                    ForEach(1..<gridModel.gridSize+1, id: \.self) { j in
//                        if let site = gridModel.siteFor(row: i, col: j) {
//                            SiteView(site: site, gridModel: gridModel)
//                        }
//                    }
//                }
//            }
        }
    }
}
