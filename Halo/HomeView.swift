//
//  ContentView.swift
//  Halo
//
//  Created by Gdwn16 on 05/02/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        ScrollView {
            
            Image("BrainIllustration")
                .resizable()
                .frame(width: 400, height: 400)
            
            HaloText(text: "I need to use another font")
            
        }
        .frame(maxWidth: .infinity)
        .noiseBackground()
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
}
