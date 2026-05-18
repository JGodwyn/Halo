//
//  MigraineLogCard.swift
//  Halo
//
//  Created by Gdwn16 on 16/05/2026.
//

import SwiftUI
import SwiftData

struct MigraineLogCard: View {

    let episode: MigraineEpisode

    // MARK: - Derived display values

    /// The date the migraine occurred (or was logged if occurredAt is missing).
    private var logDateText: String {
        let date = episode.occurredAt ?? episode.createdAt
        return date.formatted(date: .abbreviated, time: .omitted)
    }

    /// Human-readable migraine type label.
    private var typeLabel: String {
        episode.migraineTypeEnum?.label ?? "Migraine log"
    }

    /// When the entry was created in the app.
    private var addedDateText: String {
        episode.createdAt.formatted(date: .abbreviated, time: .shortened)
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 4) {
                HaloText(text: "Log @", style: .bodyLg, color: HaloColor.textSubtle)
                HaloText(text: logDateText, style: .bodyLg)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            HaloText(text: typeLabel)
                .lineLimit(1)

            HaloText(text: addedDateText, style: .bodyMd, color: HaloColor.textSubtle)
        }
        .padding(.vertical, 16)
        .padding(.trailing, 16)
        .padding(.leading, 40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .mask(alignment: .trailing) {
            ZStack(alignment: .leading) {
                Rectangle() // keeps the full card visible
                
                VStack(spacing: 4) {
                    Group {
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                        Circle()
                    }
                    .frame(width: 12, height: 12)
                }
                .padding(12)
                .blendMode(.destinationOut)
                
//                Image("PunctureMarks")
//                    .blendMode(.destinationOut) // punches holes where the image is
            }
            .compositingGroup() // required for destinationOut to work
        }
    }
}

// MARK: - Preview

#Preview {
    let config    = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: MigraineEpisode.self, configurations: config)

    let episode = MigraineEpisode(userId: "preview-user")
    episode.migraineType = MigraineType.incoming.rawValue
    episode.occurredAt   = Date()
    container.mainContext.insert(episode)

    return ZStack {
        Color.clear.noiseBackground()
        MigraineLogCard(episode: episode)
            .padding()
    }
    .modelContainer(container)
    .environment(\.font, .custom("LibreCaslonText-Regular", size: 17, relativeTo: .body))
    .environment(AuthManager())
    .preferredColorScheme(.dark)
}



struct PunctureMarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Full card
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: 16, height: 16),
            style: .continuous
        )
        
        // Punch out circles (adjust x/y/radius to match your marks)
        let radius: CGFloat = 12
        let x = rect.maxX - radius
        for y in [rect.minY - radius, rect.maxY - radius] {
            path.addEllipse(in: CGRect(
                x: x, y: y,
                width: radius * 2, height: radius * 2
            ))
        }
        
        return path
    }
    
    var eoFill: Bool { true }
}
