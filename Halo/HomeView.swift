//
//  ContentView.swift
//  Halo
//
//  Created by Gdwn16 on 05/02/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(AuthManager.self) var auth
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    
    var body: some View {
        ScrollView {
            MainButton(label: "Log Out") {
                auth.logOut()
            }
        }
        .frame(maxWidth: .infinity)
        .noiseBackground()
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .environment(AuthManager())
}
