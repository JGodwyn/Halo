//
//  EntryView.swift
//  Halo
//
//  Created by Gdwn16 on 26/02/2026.
//

import SwiftUI

struct EntryView: View {
    
    @Environment(AuthManager.self) var auth
    
    var body: some View {
        ZStack {
            if auth.isLoggedIn {
                HomeView()
                    .transition(.opacity)
            }
            
            if !auth.isLoggedIn {
                AuthView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    EntryView()
        .environment(AuthManager())
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
}
