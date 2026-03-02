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
            VStack {
                HaloText(text: "This is your user name")
                Text(auth.userName ?? "No name provided")
                    .fontStyle(.bodyLg)
                
                HaloText(text: "This is your date of birth")
                if let dob = auth.dateOfBirth {
                    Text(dob.formatted(date: .abbreviated, time: .omitted))
                        .fontStyle(.bodyLg)
                }
                
                
                MainButton(label: "Log Out") {
                    auth.logOut()
                }
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
