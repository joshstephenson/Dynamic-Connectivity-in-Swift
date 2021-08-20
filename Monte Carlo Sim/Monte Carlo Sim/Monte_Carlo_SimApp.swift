//
//  Monte_Carlo_SimApp.swift
//  Monte Carlo Sim
//
//  Created by Joshua Stephenson on 8/13/21.
//

import SwiftUI

let kGridSize = 10

@main
struct Monte_Carlo_SimApp: App {
    @StateObject private var gridModel = GridModel(n: kGridSize)
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(gridModel)
        }
    }
}
