//
//  DaylineApp.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/17/26.
//

import SwiftUI
import SwiftData

@main
struct DaylineApp: App {

    @AppStorage("hasCompletedOnboarding")    
    private var hasCompletedOnboarding = false

    var body: some Scene {
    
        WindowGroup {
            RootTabView()
        }
        .modelContainer(for: SavedEdition.self)
    }
}

