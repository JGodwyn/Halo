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
            Text("I need to use another font")
                .foregroundStyle(HaloTheme.textBold)
        }
        .frame(maxWidth: .infinity)
        .background(HaloTheme.surface2)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
