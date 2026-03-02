//
//  HaloApp.swift
//  Halo
//
//  Created by Gdwn16 on 05/02/2026.
//

import SwiftUI
import SwiftData

@main
struct HaloApp: App {
    
    @State var authObj = AuthManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            EntryView()
                .preferredColorScheme(.dark)
                .noiseBackground()
        }
        .environment(authObj)
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .modelContainer(sharedModelContainer)
    }
}
