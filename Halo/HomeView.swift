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
                .foregroundStyle(HaloColor.textBold)
                .textStyle(HaloFont.bodyLg)
        }
        .frame(maxWidth: .infinity)
        .background(HaloColor.surface2)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
