//
//  MigraineManager.swift
//  Halo
//
//  Created by Gdwn16 on 07/03/2026.
//

import Foundation
import SwiftData

// MARK: - Enums

enum MigraineSituations {
    // for displaying the migraine. Note that there's no 'didnotoccur' here
    // that's cos a state has to be incoming before it is 'didnotoccur'
    case incoming
    case active
    case aftermath
    case resolved
    
    var description : String {
        switch self {
        case .incoming:
            return "I think a migraine is coming"
        case .active:
            return "I am currently having an attack"
        case .aftermath:
            return "It’s gone but I still feel the effects"
        case .resolved:
            return "It’s totally gone"
        }
    }
    
    var numberOfTabs : Int {
        switch self {
        case .incoming:
            return 2
        case .active:
            return 2
        case .aftermath:
            return 8
        case .resolved:
            return 8
        }
    }
    
    var loggingConfirmationImage : String {
        switch self {
            case .incoming:
                return "ThumbsUp"
            case .active:
                return "EtherealFlame"
            case .aftermath:
                return "EtherealFlame"
            case .resolved:
                return "ThumbsUp"
        }
    }
    
    var loggingConfirmationHeader : String {
        switch self {
            case .incoming:
                return "Got it"
            case .active:
                return "Get some rest"
            case .aftermath:
                return "Get some rest"
            case .resolved:
                return "Logged!"
        }
    }
    
    var loggingConfirmationDescription : String {
        switch self {
            case .incoming:
                return "We’ve saved your log. You’ll get a reminder in 30 minutes to see how you’re feeling."
            case .active:
                return "That’s enough for now. You can fill the other information later."
            case .aftermath:
                return "Post-migraine hangovers are real. Make sure to rest so you can fully recover."
            case .resolved:
                return "Thanks for checking in."
        }
    }

    /// Maps the UX-facing situation to the stored MigraineType value.
    var asMigraineType: MigraineType {
        switch self {
        case .incoming:  .incoming
        case .active:    .active
        case .aftermath: .aftermath
        case .resolved:  .resolved
        }
    }
}

enum MigraineType: String, Codable, CaseIterable {
    case incoming       = "incoming"
    case active         = "active"
    case aftermath      = "aftermath"
    case resolved       = "resolved"
    case didNotOccur    = "did_not_occur"

    var label: String {
        switch self {
        case .incoming:   "I think a migraine is coming"
        case .active:     "I am currently having an attack"
        case .aftermath:  "It's gone but I still feel the after effects"
        case .resolved:   "It's totally gone"
        case .didNotOccur: "It didn't happen after all"
        }
    }
}

enum AuraStatus: String, Codable, CaseIterable {
    case yes    = "yes"
    case no     = "no"
    case unsure = "unsure"

    var label: String {
        switch self {
        case .yes:    "Yes, the aura is present"
        case .no:     "No, there's no aura"
        case .unsure: "I can't tell for now"
        }
    }
}

enum PainIntensity: String, Codable, CaseIterable {
    case intense  = "intense"
    case moderate = "moderate"
    case mild     = "mild"

    var label: String { rawValue.capitalized }
}

enum PainCause: String, Codable, CaseIterable {
    case sleep          = "sleep"
    case stress         = "stress"
    case food           = "food"
    case light          = "light"
    case screenTime     = "screen_time"
    case dehydration    = "dehydration"
    case menstrualCycle = "menstrual_cycle"
    case unknown        = "unknown"
    case other          = "other"

    var label: String {
        switch self {
        case .sleep:          "Sleep"
        case .stress:         "Stress"
        case .food:           "Food"
        case .light:          "Light"
        case .screenTime:     "Screen Time"
        case .dehydration:    "Dehydration"
        case .menstrualCycle: "Menstrual Cycle"
        case .unknown:        "I don't know"
        case .other:          "Write something else"
        }
    }
}

enum PainLocation: String, Codable, CaseIterable {
    case forehead      = "forehead"
    case temple        = "temple"
    case behindEyes    = "behind_eyes"
    case topOfHead     = "top_of_head"
    case backOfHeadNeck = "back_of_head_neck"
    case sinusesJaws   = "sinuses_jaws"
    case entireHead    = "entire_head"
    case unknown       = "unknown"

    var label: String {
        switch self {
        case .forehead:       "Forehead"
        case .temple:         "Temple"
        case .behindEyes:     "Behind Eyes"
        case .topOfHead:      "Top of the Head"
        case .backOfHeadNeck: "Back of Head / Neck"
        case .sinusesJaws:    "Sinuses / Jaws"
        case .entireHead:     "Entire Head / Scalp"
        case .unknown:        "I don't remember"
        }
    }
    
    var image: String {
        switch self {
        case .forehead:       "Forehead"
        case .temple:         "Temple"
        case .behindEyes:     "BehindEyes"
        case .topOfHead:      "TopOfTheHead"
        case .backOfHeadNeck: "BackOfHeadNeck"
        case .sinusesJaws:    "SinusesJaws"
        case .entireHead:     "EntireHeadScalp"
        case .unknown:        "IDontRemember"
        }
    }
}

enum MedicationTaken: String, Codable, CaseIterable {
    case yes    = "yes"
    case no     = "no"
    case unsure = "unsure"

    var label: String {
        switch self {
        case .yes:    "Yes"
        case .no:     "No"
        case .unsure: "I don't know"
        }
    }
}

enum MedicationHelped: String, Codable, CaseIterable {
    case yes    = "yes"
    case no     = "no"
    case unsure = "unsure"

    var label: String {
        switch self {
        case .yes:    "Yes"
        case .no:     "No"
        case .unsure: "I don't know"
        }
    }
}


// MARK: - Model

@Model
final class MigraineEpisode {
    var id: UUID
    var userId: String
    var note: String?
    var migraineType: String?
    /// Single combined timestamp — maps to `occurred_at timestamptz` in Supabase.
    /// The UX collects day and time separately; they are merged before commit.
    var occurredAt: Date?
    var durationHours: Int?
    var durationMinutes: Int?
    var aura: String?
    var painIntensity: String?
    var painCauses: [String]       // raw values of PainCause
    var customCause: String?       // populated when 'other' is selected
    var painLocations: [String]    // raw values of PainLocation
    var medicationTaken: String?
    var medicationTakenNote: String?
    var medicationHelped: String?
    var medicationHelpedNote: String?
    var createdAt: Date
    var updatedAt: Date
    var isSynced: Bool             // false until successfully pushed to Supabase

    init(userId: String) {
        self.id = UUID()
        self.userId = userId
        self.painCauses = []
        self.painLocations = []
        self.createdAt = Date()
        self.updatedAt = Date()
        self.isSynced = false
    }

    // Typed computed accessors so views never touch raw strings
    var migraineTypeEnum: MigraineType? {
        get { migraineType.flatMap { MigraineType(rawValue: $0) } }
        set { migraineType = newValue?.rawValue }
    }
    var auraEnum: AuraStatus? {
        get { aura.flatMap { AuraStatus(rawValue: $0) } }
        set { aura = newValue?.rawValue }
    }
    var painIntensityEnum: PainIntensity? {
        get { painIntensity.flatMap { PainIntensity(rawValue: $0) } }
        set { painIntensity = newValue?.rawValue }
    }
    var painCausesEnum: [PainCause] {
        get { painCauses.compactMap { PainCause(rawValue: $0) } }
        set { painCauses = newValue.map { $0.rawValue } }
    }
    var painLocationsEnum: [PainLocation] {
        get { painLocations.compactMap { PainLocation(rawValue: $0) } }
        set { painLocations = newValue.map { $0.rawValue } }
    }
    var medicationHelpedEnum: MedicationHelped? {
        get { medicationHelped.flatMap { MedicationHelped(rawValue: $0) } }
        set { medicationHelped = newValue?.rawValue }
    }
    var medicationTakenEnum: MedicationTaken? {
        get { medicationTaken.flatMap { MedicationTaken(rawValue: $0) } }
        set { medicationTaken = newValue?.rawValue }
    }
}


// hold the migraine fields as the user goes through the flow

struct MigraineEpisodeDraft {

    // MARK: - Identity

    /// nil  → this draft will create a brand-new MigraineEpisode on commit.
    /// non-nil → this draft will patch the existing episode with the matching id.
    var episodeId: UUID? = nil

    // MARK: - Fields

    var note: String = ""
    var migraineType: MigraineType? = nil
    /// Separate picker bindings — the user picks day and time independently in the UI.
    /// Use `occurredAt` (the derived merge) when writing to the model.
    var pickedDay: Date = Date()    // DatePicker displayedComponents: .date
    var pickedTime: Date = Date()   // DatePicker displayedComponents: .hourAndMinute
    var durationHours: Int? = nil
    var durationMinutes: Int? = nil
    var aura: AuraStatus? = nil
    var painIntensity: PainIntensity? = nil
    var painCauses: [String] = []
    var customCause: String = ""
    var painLocations: [String] = []
    var medicationTaken: MedicationTaken? = nil
    var medicationTakenNote: String = ""
    var medicationHelped: MedicationHelped? = nil
    var medicationHelpedNote: String = ""

    // MARK: - Derived

    /// Merges the two picker selections into a single Date.
    /// e.g. pickedDay = Sept 15 2026, pickedTime = 07:50 → Sept 15 2026 07:50:00 local
    var occurredAt: Date {
        let cal = Calendar.current
        let hour   = cal.component(.hour,   from: pickedTime)
        let minute = cal.component(.minute, from: pickedTime)
        return cal.date(bySettingHour: hour, minute: minute, second: 0, of: pickedDay) ?? pickedDay
    }

    // MARK: - Factory: continuing an existing episode

    /// Builds a draft pre-populated from a live MigraineEpisode.
    /// Use this when the user is updating a previously logged episode
    /// (e.g. an incoming log that is now resolving, or marking didNotOccur).
    ///
    /// Because pickedDay/pickedTime are seeded from the existing occurredAt,
    /// skipping the migraineStart step during the update flow is safe —
    /// occurredAt will round-trip to the same value rather than resetting to Date().
    static func continuing(from episode: MigraineEpisode) -> MigraineEpisodeDraft {
        var draft = MigraineEpisodeDraft()
        draft.episodeId             = episode.id
        draft.note                  = episode.note ?? ""
        draft.aura                  = episode.auraEnum
        draft.painIntensity         = episode.painIntensityEnum
        draft.painCauses            = episode.painCauses
        draft.customCause           = episode.customCause ?? ""
        draft.painLocations         = episode.painLocations
        draft.medicationTaken       = episode.medicationTakenEnum
        draft.medicationTakenNote   = episode.medicationTakenNote ?? ""
        draft.medicationHelped      = episode.medicationHelpedEnum
        draft.medicationHelpedNote  = episode.medicationHelpedNote ?? ""
        // Seed pickers from the existing timestamp so skipping migraineStart is safe
        if let date = episode.occurredAt {
            draft.pickedDay  = date
            draft.pickedTime = date
        }
        return draft
    }

    // MARK: - Commit

    /// Creates a new episode or patches the existing one, depending on episodeId.
    @discardableResult
    func commit(to context: ModelContext, userId: String) -> MigraineEpisode {
        if let id = episodeId {
            return updateExisting(id: id, in: context)
        } else {
            return createNew(in: context, userId: userId)
        }
    }

    // MARK: - Private helpers

    private func createNew(in context: ModelContext, userId: String) -> MigraineEpisode {
        let episode = MigraineEpisode(userId: userId)
        apply(to: episode, overwriteAll: true)
        context.insert(episode)
        return episode
    }

    private func updateExisting(id: UUID, in context: ModelContext) -> MigraineEpisode {
        let descriptor = FetchDescriptor<MigraineEpisode>(
            predicate: #Predicate { $0.id == id }
        )
        guard let episode = (try? context.fetch(descriptor))?.first else {
            // Defensive fallback — should never happen in normal flow
            assertionFailure("MigraineEpisodeDraft.updateExisting: no episode found for id \(id)")
            let fallback = MigraineEpisode(userId: "")
            apply(to: fallback, overwriteAll: true)
            return fallback
        }
        apply(to: episode, overwriteAll: false)
        return episode
    }

    /// Writes draft fields into a MigraineEpisode.
    ///
    /// - `overwriteAll: true`  — used on **create**: every field is written,
    ///   including nils (which clear any pre-existing value).
    /// - `overwriteAll: false` — used on **update**: only non-nil / non-empty
    ///   fields are written so earlier-phase data from a previous session is
    ///   never accidentally cleared.
    private func apply(to episode: MigraineEpisode, overwriteAll: Bool) {
        // Always stamp migraineType and updatedAt regardless of mode
        episode.migraineTypeEnum = migraineType
        episode.updatedAt        = Date()
        episode.isSynced         = false

        if overwriteAll {
            episode.note                 = note.isEmpty ? nil : note
            episode.occurredAt           = occurredAt
            episode.durationHours        = durationHours
            episode.durationMinutes      = durationMinutes
            episode.auraEnum             = aura
            episode.painIntensityEnum    = painIntensity
            episode.painCauses           = painCauses
            episode.customCause          = painCauses.contains("other") ? customCause : nil
            episode.painLocations        = painLocations
            episode.medicationTakenEnum  = medicationTaken
            episode.medicationTakenNote  = medicationTakenNote.isEmpty ? nil : medicationTakenNote
            episode.medicationHelpedEnum = medicationHelped
            episode.medicationHelpedNote = medicationHelpedNote.isEmpty ? nil : medicationHelpedNote
        } else {
            // Patch only the fields the user touched in this session.
            // nil/empty means the step was skipped → leave the existing value intact.
            if !note.isEmpty             { episode.note = note }
            // occurredAt: pickedDay/pickedTime are seeded from the existing value in
            // continuing(from:), so this is a no-op when migraineStart is skipped.
            episode.occurredAt = occurredAt
            if let v = durationHours     { episode.durationHours = v }
            if let v = durationMinutes   { episode.durationMinutes = v }
            if let v = aura              { episode.auraEnum = v }
            if let v = painIntensity     { episode.painIntensityEnum = v }
            if !painCauses.isEmpty {
                episode.painCauses  = painCauses
                episode.customCause = painCauses.contains("other") ? customCause : nil
            }
            if !painLocations.isEmpty    { episode.painLocations = painLocations }
            if let v = medicationTaken   { episode.medicationTakenEnum = v }
            if !medicationTakenNote.isEmpty  { episode.medicationTakenNote = medicationTakenNote }
            if let v = medicationHelped  { episode.medicationHelpedEnum = v }
            if !medicationHelpedNote.isEmpty { episode.medicationHelpedNote = medicationHelpedNote }
        }
    }
}
