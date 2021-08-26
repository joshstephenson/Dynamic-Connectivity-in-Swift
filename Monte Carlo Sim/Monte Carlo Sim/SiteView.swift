//
//  SiteView.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/20/21.
//

import SwiftUI

enum SiteState {
    case closed
    case open
    case full
    case shortestPath
}

struct SiteView : View {
    @ObservedObject var site: Site
    @ObservedObject var gridModel: GridModel
    private var color:Color {
        switch site.state {
        case .closed:
            return Color.init("closed")
        case .open:
            return Color.init("open")
        case .full:
            return Color.init("full")
        case .shortestPath:
            return Color.init("shortestPath")
        }
    }
    var tap: some Gesture {
        TapGesture(count:1)
            .onEnded { _ in
                self.open()
            }
    }
    
    private func open() {
        site.open()
    }
    
    var body: some View {
            Rectangle()
                .fill(self.color)
                .frame(width:600.0/CGFloat(gridModel.gridSize)-2,
                       height:600.0/CGFloat(gridModel.gridSize)-2,
                       alignment: .leading)
                .gesture(tap)
    }
    
}

