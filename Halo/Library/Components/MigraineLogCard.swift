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
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(HaloColor.surface1, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
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
