//
//  MigraineLogDetailView.swift
//  Halo
//
//  Created by Gdwn16 on 21/05/2026.
//

import SwiftUI
import SwiftData
internal import Realtime

struct MigraineLogDetailView: View {
    let episode: MigraineEpisode
    
    @State private var showingEditFlow = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                

                
                // MARK: - Log Fields
                VStack(alignment: .leading, spacing: 24) {
                    
                    HaloText(text: "Your entry", style: .headingSm)
                    
                    Button {
                        // change the status
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            HaloText(text: "Current status", style: .bodyMd, color: HaloColor.textSubtle)
                            HStack {
                                HaloText(
                                    text: episode.migraineTypeEnum?.label ?? "Migraine log",
                                    style: .bodyLg
                                )
                                .truncationMode(.tail)
                                .lineLimit(1)
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 16))
                                    .foregroundStyle(HaloColor.iconSubtle)
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    
                    infoCard(label: "The day is", content: logDateText)
                    
                    infoCard(label: "The migraine started", content: logTimeText)
                    
                    infoCard(label: "It lasted for", content: durationText)
                    
                    infoCard(label: "The aura was", content: auraText)
                    
                    infoCard(label: "The pain was", content: intensityText)
                    
                    infoCard(label: "What might have caused it?", content: causesText, structure: .vertical)
                    
                    infoCard(label: "The pain was in", content: locationsText, structure: .vertical)
                    
                    infoCard(label: "I took", content: medicationTakenText)
                    
                    if let medNote = episode.medicationTakenNote, !medNote.isEmpty {
                        infoCard(label: "Medication notes", content: medNote)
                    }
                    
                    if episode.medicationTakenEnum == .yes || episode.medicationTakenEnum == .unsure {
                        infoCard(label: "Medication helped?", content: medicationHelpedText)
                        if let helpedNote = episode.medicationHelpedNote, !helpedNote.isEmpty {
                            infoCard(label: "Effect notes", content: helpedNote)
                        }
                    }
                    
                    VStack {
                        HaloText(text: "Your notes")
                        // MARK: - Summary Note
                        if let note = episode.note, !note.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "wand.and.sparkles")
                                        .foregroundStyle(HaloColor.iconSubtle)
                                    HaloText(text: "Summary", color: HaloColor.textSubtle)
                                }
                                
                                HaloText(text: note, style: .titleLg)
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                        }
                    }
                }
                .padding(.vertical, Padding.mgnMobile)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, Padding.mgnMobile)
        .frame(maxWidth: .infinity)
        .noiseBackground()
        .toolbar {
            ToolbarItem(placement: .principal) {
                HaloText(
                    text: episode.createdAt.formatted(date: .abbreviated, time: .omitted),
                    style: .bodyLg
                )
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingEditFlow = true
                } label: {
                    HaloText(text: "Edit", color: HaloColor.textSubtle)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEditFlow) {
            MigraineQuestionTemplateView(
                migraineSituation: episode.migraineTypeEnum?.asSituation ?? .resolved,
                initialDraft: MigraineEpisodeDraft.continuing(from: episode)
            ) {
                showingEditFlow = false
            }
        }
    }
    
    // MARK: - Computed Properties for Fields
    
    private var logDateText: String {
        episode.occurredAt?.formatted(date: .abbreviated, time: .omitted) ?? "What date?"
    }
    
    private var logTimeText: String {
        episode.occurredAt?.formatted(date: .omitted, time: .shortened) ?? "What time?"
    }
    
    private var durationText: String {
        let hours = episode.durationHours ?? 0
        let minutes = episode.durationMinutes ?? 0
        if hours == 0 && minutes == 0 {
            return "How long?"
        }
        var parts: [String] = []
        if hours > 0 {
            parts.append("\(hours) hr\(hours > 1 ? "s" : "")")
        }
        if minutes > 0 {
            parts.append("\(minutes) min\(minutes > 1 ? "s" : "")")
        }
        return parts.joined(separator: " ")
    }
    
    private var auraText: String {
        episode.auraEnum?.label ?? "Choose aura status"
    }
    
    private var intensityText: String {
        episode.painIntensityEnum?.label ?? "How intense?"
    }
    
    private var causesText: String {
        let causes = episode.painCausesEnum
        if causes.isEmpty {
            return "Choose causes"
        }
        let causeLabels = causes.map { cause -> String in
            if cause == .other, let custom = episode.customCause, !custom.isEmpty {
                return custom
            }
            return cause.label
        }
        return causeLabels.joined(separator: ", ")
    }
    
    private var locationsText: String {
        let locations = episode.painLocationsEnum
        if locations.isEmpty {
            return "Choose area"
        }
        return locations.map { $0.label }.joined(separator: ", ")
    }
    
    private var medicationTakenText: String {
        episode.medicationTakenEnum?.label ?? "Choose medication"
    }
    
    private var medicationHelpedText: String {
        episode.medicationHelpedEnum?.label ?? "Not set"
    }
    
    // MARK: - Helper Views
    
    @ViewBuilder
    private func infoCard(label: String, content: String, structure: infoCardType = .horizontal) -> some View {
        Button {
            showingEditFlow = true
        } label: {
            structure.content(label: label, content: content)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Helper Extensions

extension MigraineType {
    var asSituation: MigraineSituations {
        switch self {
        case .incoming: return .incoming
        case .active: return .active
        case .aftermath: return .aftermath
        case .resolved, .didNotOccur: return .resolved
        }
    }
}

#Preview {
    let config    = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MigraineEpisode.self, configurations: config)
    
    let episode = MigraineEpisode(userId: "preview-user")
    episode.migraineType = MigraineType.aftermath.rawValue
    episode.occurredAt   = Date()
    container.mainContext.insert(episode)
    
    return NavigationStack {
        MigraineLogDetailView(episode: episode)
    }
    .modelContainer(container)
    .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
    .environment(AuthManager())
    .preferredColorScheme(.dark)
}


enum infoCardType {
    case horizontal
    case vertical
    
    @ViewBuilder
    func content(label: String, content: String) -> some View {
        switch self {
        case .horizontal:
            HStack(spacing: 8) {
                HaloText(text: label, color: HaloColor.textSubtle)
                HStack(spacing: 4) {
                    HaloText(text: content)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Image(systemName: "pencil")
                        .font(.system(size: 16))
                        .foregroundStyle(HaloColor.iconSubtle)
                }
                .padding(.horizontal, 12)
                .frame(minHeight: 32)
                .padding(.vertical, 4)
                .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
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
        case .vertical:
            VStack(alignment: .leading, spacing: 8) {
                HaloText(text: label, color: HaloColor.textSubtle)
                HStack(spacing: 4) {
                    HaloText(text: content)
                    Image(systemName: "pencil")
                        .font(.system(size: 16))
                        .foregroundStyle(HaloColor.iconSubtle)
                }
                .padding(.horizontal, 12)
                .frame(minHeight: 32)
                .padding(.vertical, 4)
                .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
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
}
