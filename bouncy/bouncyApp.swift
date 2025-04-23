//
//  bouncyApp.swift
//  bouncy
//
//  Created by Nico on 4/17/25.
//

import SwiftUI
import SwiftData

@main
struct bouncyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: HighScore.self)
    }
}
