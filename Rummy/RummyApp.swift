//
//  RummyApp.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/13/24.
//

import SwiftUI
import SwiftData

@main
struct RummyApp: App {
    var body: some Scene {
        WindowGroup {
            GameListView()
        }
        .modelContainer(for: Game.self)
    }
}
