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
    @State private var showLoggingSheet : Bool = false
    @State private var migraineSituation : MigraineSituations?
    @State private var moveToMigraineQuestions : Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                firstTimeView
            }
            .padding(.horizontal, Padding.mgnMobile)
            .noiseBackground()
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
                migraineTypeView
                    .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
        .overlay(alignment: .top) {
            if auth.showConnectHealthProvider {
                ConnectHealthProviderView()
                    .noiseBackground(transitions: true, isPresented: Binding(
                        get: { auth.showConnectHealthProvider },
                        set: { auth.showConnectHealthModal($0) }
                    ))
                    .transition(.blurReplace.combined(with: .scale(1.2, anchor: .center)))
            }
        }
        .overlay {
            if let situation = migraineSituation {
                MigraineQuestionTemplateView(migraineSituation: situation) {
                    withAnimation(.easeOut) {
                        migraineSituation = nil
                    }
                }
            }
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 1), value: showLoggingSheet)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    var migraineTypeView : some View {
        ZStack {
            Group {
                BlurView(style: .systemThinMaterialDark)
                Color.black.opacity(0.3)
            }
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                HaloText(text: "Are you experiencing a migraine?", style: .headingMd)
                    .padding(.bottom, 8)
                
                SelectPill(label: "I think a migraine is coming") {
                    moveToMigrainQuestions(situation: .incoming)
                }
                
                SelectPill(label: "I am currently having an attack") {
                    moveToMigrainQuestions(situation: .active)
                }
                
                SelectPill(label: "It’s gone but I still feel the effects") {
                    moveToMigrainQuestions(situation: .aftermatch)
                }
                
                SelectPill(label: "It’s totally gone") {
                    moveToMigrainQuestions(situation: .resolved)
                }
            }
            .padding(.horizontal, Padding.mgnMobile)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(alignment: .bottom) {
            MainButton(state: .clear, label: "Cancel", fillContainer: true) {
                showLoggingSheet = false
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .environment(AuthManager())
}


enum MigraineSituations {
    case incoming
    case active
    case aftermatch
    case resolved
    
    var description : String {
        switch self {
        case .incoming:
            return "I think a migraine is coming"
        case .active:
            return "I am currently having an attack"
        case .aftermatch:
            return "It’s gone but I still feel the effects"
        case .resolved:
            return "It’s totally gone"
        }
    }
}

private extension HomeView {
    func moveToMigrainQuestions (situation : MigraineSituations) {
        showLoggingSheet = false
        migraineSituation = situation
        Task {
            try? await Task.sleep(for: .seconds(0.2))
            moveToMigraineQuestions = true
        }
    }
}
