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
    @Query(sort: \MigraineEpisode.createdAt, order: .reverse) private var episodes: [MigraineEpisode]
    @State private var startLoggingAttack : Bool = false
    @State private var showLoggingSheet : Bool = false
    @State private var showLoggingOptions : Bool = false
    @State private var migraineSituation : MigraineSituations?
//    @State private var moveToMigraineQuestions : Bool = false
    @State private var startAftermathFlow : Bool = false
    @GestureState private var addBtnPressed : Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if episodes.isEmpty {
                    firstTimeView
                        .padding(.horizontal, Padding.mgnMobile)
                } else {
                    contentView
                        .padding(.horizontal, Padding.mgnMobile)
                    floatingButton
                }
            }
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
                    withAnimation(.easeOut(duration: 0.3)) {
                        migraineSituation = nil
                    }
                }
            }
        }
        .animation(.easeOut(duration: 0.3), value: migraineSituation)
        .overlay {
            if startAftermathFlow {
                MTakeYourTimeView {
                    withAnimation(.easeOut(duration: 0.3)){
                        startAftermathFlow = false
                    }
                }
            }
        }

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
                    
                    HaloText(text: "Your first log...", style: .headingLg)
                    
                    HaloText(text: "Start by logging a migraine attack or entering a note. We’ll give you tips as you keep using the app.", style: .bodyLg, color: HaloColor.textSubtle)
                }
                
                VStack (spacing: 16) {
                    MainButton(label: "Log Migraine Attack", icon: "plus", fillContainer: true) {
                        withAnimation(.easeOut(duration: 0.3)){
                            showLoggingSheet = true
                        }
                    }
                    
                    MainButton(state: .secondary, label: "Add Note Instead", fillContainer: true) {
                        
                    }
                }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center) {
                    HaloText(text: "Recent attacks", style: .headingSm)
                    Spacer()
                    Button {

                    } label: {
                        HaloText(text: "See All", style: .bodyLg, color: HaloColor.textSubtle)
                    }
                }

                VStack(spacing: 8) {
                    ForEach(episodes) { episode in
                        MigraineLogCard(episode: episode)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(HaloColor.surface2, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .frame(maxWidth: .infinity)
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
                    // just open the confirmation view
                    // inside it will open the questionnaire'
                    withAnimation(.easeOut(duration: 0.3)){
                        startAftermathFlow = true
                        moveToMigrainQuestions(situation: .aftermath)
                    }
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
                withAnimation(.easeOut(duration: 0.3)){
                    showLoggingSheet = false
                }
            }
        }
    }
    
    var floatingButton : some View {
        ZStack(alignment: .bottomTrailing) {
            if showLoggingOptions {
                Color.clear
                    .contentShape(Rectangle()) // makes it tappable
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.6)) {
                            showLoggingOptions = false
                        }
                    }
                
                Group {
                    BlurView(style: .dark)
                    Color.black.opacity(0.2)
                    }
                    .ignoresSafeArea()
                
            }
            
            Image(systemName: "plus")
                .font(.system(size: 24))
                .foregroundColor(BrandColor.Gray.gray0)
                .padding()
                .frame(width: 96, height: 96)
                .background(BrandColor.Powder.powder100)
                .clipShape(Circle())
                .mask {
                    Image("RoughEdgedCircle")
                        .resizeImageTo(104)
                }
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                .padding(12)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .updating($addBtnPressed) { _, state, _ in state = true }
                        .onEnded { _ in                             withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.6)) {
                            showLoggingOptions.toggle()
                        } }
                )
                .scaleEffect(addBtnPressed ? 0.6 : 1.0)
                .blur(radius: addBtnPressed ? 8 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: addBtnPressed)
                .rotationEffect(.degrees(showLoggingOptions ? 135 : 0))
            
            // floating options
            if showLoggingOptions {
                VStack(alignment: .leading) {
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            showLoggingSheet = true
                            showLoggingOptions = false
                        }
                    } label: {
                        HStack(spacing: 16) {
                            HaloText(text: "Log new attack", style: .headingSm)
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundStyle(HaloColor.iconSubtle)
                        }
                        .padding(.bottom, 8)
                        .frame(height: 64)
                        .overlay(alignment: .bottom) {
                            GeometryReader { geo in
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                                }
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 8]))
                                .foregroundStyle(HaloColor.iconBold)
                                .frame(height: 1)
                            }
                            .frame(height: 1)
                        }
                    }
                    
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 16) {
                            HaloText(text: "Add a note", style: .headingSm)
                            Image(systemName: "pencil")
                                .font(.system(size: 24))
                                .foregroundStyle(HaloColor.iconSubtle)
                        }
                        .padding(.bottom, 8)
                        .frame(height: 64)
                        .overlay(alignment: .bottom) {
                            GeometryReader { geo in
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                                }
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 8]))
                                .foregroundStyle(HaloColor.iconBold)
                                .frame(height: 1)
                            }
                            .frame(height: 1)
                        }
                    }
                    
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 16) {
                            HaloText(text: "Aura simulator", style: .headingSm)
                            Image(systemName: "eye")
                                .font(.system(size: 20))
                                .foregroundStyle(HaloColor.iconSubtle)
                        }
                        .padding(.bottom, 8)
                        .frame(height: 64)
                        .overlay(alignment: .bottom) {
                            GeometryReader { geo in
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                                }
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 8]))
                                .foregroundStyle(HaloColor.iconBold)
                                .frame(height: 1)
                            }
                            .frame(height: 1)
                        }
                    }
                }
                .transition(.scale(0.5, anchor: .bottomTrailing).combined(with: .blurReplace))
                .padding()
                .contentShape(Rectangle())
                .offset(x: -24, y: -128)
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: MigraineEpisode.self, inMemory: true)
        .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
        .environment(AuthManager())
        .preferredColorScheme(.dark)
}


private extension HomeView {
    func moveToMigrainQuestions (situation : MigraineSituations) {
        withAnimation (.easeOut(duration: 0.3)) {
            showLoggingSheet = false
        }
        migraineSituation = situation
        Task {
            try? await Task.sleep(for: .seconds(0.2))
//            moveToMigraineQuestions = true
        }
    }
}
