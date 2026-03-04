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
    @State private var startLoggingAttack : Bool = false
    @State private var showLoggingSheet : Bool = true
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                firstTimeView
            }
            .noiseBackground()
            .overlay(alignment: .top) {
                if auth.showConnectHealthProvider {
                    ConnectHealthProviderView()
                        .transition(.move(edge: .top).combined(with: .scale).combined(with: .opacity))
                }
            }
            .toolbar(auth.showConnectHealthProvider ? .hidden : .visible)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        auth.logOut()
                    } label: {
                        Image("ProfileDefaultAvatar")
                            .resizeImageTo(36)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Image("Logomark")
                        .resizeImageTo(88)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        auth.showConnectHealthModal(true)
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
                
            }
        }
        .overlay {
            if showLoggingSheet {
                ZStack {
                    Color.black.opacity(0.8)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        HaloText(text: "Are you experiencing a migraine?", style: .headingMd)
                        
                        
                        MainButton(label: "Close overlay", fillContainer: true) {
                            showLoggingSheet = false
                        }
                    }
                    .padding(.horizontal, Padding.mgnMobile)
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                .ignoresSafeArea()
            }
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8), value: showLoggingSheet)
    }
    
    var firstTimeView : some View {
        ScrollView {
            VStack(alignment: .center, spacing: 32) {
                Image("EtherealHand")
                    .resizeImageTo(320)
                    .padding(.vertical, -40)
                
                VStack (spacing: 16) {
                    if let username = auth.userName {
                        Text("Hi \(username),")
                            .fontStyle(.bodyLg, color: HaloColor.textSubtle)
                    }
                    
                    HaloText(text: "Your first time...", style: .headingLg)
                    
                    HaloText(text: "Start by logging a migraine attack or entering a note. We’ll give you tips as you keep using the app.", style: .bodyLg, color: HaloColor.textSubtle)
                }
                
                VStack (spacing: 16) {
                    MainButton(label: "Log Migraine Attack", icon: "plus", fillContainer: true) {
                        showLoggingSheet = true
                    }
                    
                    MainButton(state: .secondary, label: "Add Note Instead", fillContainer: true) {
                        
                    }
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, Padding.mgnMobile)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .navigationDestination(isPresented: $startLoggingAttack) {
            MigraineQuestionTemplateView()
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .environment(AuthManager())
}
