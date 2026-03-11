//
//  MigraineManager.swift
//  Halo
//
//  Created by Gdwn16 on 07/03/2026.
//

import Foundation
import SwiftData

// MARK: - Enums

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
    var date: Date?
    var time: Date?      // store as Date, read only the time component
    var durationHours: Int?
    var durationMinutes: Int?
    var durationSeconds: Int?
    var aura: String?
    var painIntensity: String?
    var painCauses: [String]       // raw values of PainCause
    var customCause: String?       // populated when 'other' is selected
    var painLocations: [String]    // raw values of PainLocation
    var medicationTaken: Bool?
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
}


// hold the migraine fields as the user goes through the flow

struct MigraineEpisodeDraft {
    var note: String = ""
    var migraineType: MigraineType? = nil
    var date: Date = Date()
    var time: Date = Date()
    var durationHours: Int? = nil
    var durationMinutes: Int? = nil
    var durationSeconds: Int? = nil
    var aura: AuraStatus? = nil
    var painIntensity: PainIntensity? = nil
    var painCauses: [String] = []
    var customCause: String = ""
    var painLocations: [String] = []
    var medicationTaken: Bool? = nil
    var medicationTakenNote: String = ""
    var medicationHelped: MedicationHelped? = nil
    var medicationHelpedNote: String = ""

    // Converts the draft into a real SwiftData model
    func commit(to context: ModelContext, userId: String) -> MigraineEpisode {
        let episode = MigraineEpisode(userId: userId)
        episode.note                 = note.isEmpty ? nil : note
        episode.migraineTypeEnum     = migraineType
        episode.date                 = date
        episode.time                 = time
        episode.durationHours        = durationHours
        episode.durationMinutes      = durationMinutes
        episode.durationSeconds      = durationSeconds
        episode.auraEnum             = aura
        episode.painIntensityEnum    = painIntensity
        episode.painCauses           = painCauses
        episode.customCause          = painCauses.contains("other") ? customCause : nil
        episode.painLocations        = painLocations
        episode.medicationTaken      = medicationTaken
        episode.medicationTakenNote  = medicationTakenNote.isEmpty ? nil : medicationTakenNote
        episode.medicationHelpedEnum = medicationHelped
        episode.medicationHelpedNote = medicationHelpedNote.isEmpty ? nil : medicationHelpedNote
        context.insert(episode)
        return episode
    }
}
