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
}

struct SiteView : View {
    @ObservedObject var site: Site
    @ObservedObject var gridModel: GridModel
    private var color:Color {
        switch site.state {
        case .closed:
            return Color.init(white: 0.5, opacity: 1.0)
        case .open:
            return Color.white
        case .full:
            return Color.pink
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
                .frame(width:50, height:50, alignment: .leading)
                .gesture(tap)
    }
    
}

