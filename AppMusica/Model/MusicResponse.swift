//
//  MusicResponse.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftData

struct MusicResponse: Codable {
    let results: [Music]
}

@Model
final class Music: Identifiable, Codable {
    // SwiftData persisted properties must be var
    var trackId: Int
    var trackName: String
    var collectionName: String
    var trackViewUrl: String

    // Identifiable conformance using trackId
    var id: Int { trackId }

    // Designated initializer for SwiftData and manual init
    init(trackId: Int, trackName: String, collectionName: String, trackViewUrl: String) {
        self.trackId = trackId
        self.trackName = trackName
        self.collectionName = collectionName
        self.trackViewUrl = trackViewUrl
    }

    // MARK: - Codable
    private enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case collectionName
        case trackViewUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackId = try container.decode(Int.self, forKey: .trackId)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.collectionName = try container.decode(String.self, forKey: .collectionName)
        self.trackViewUrl = try container.decode(String.self, forKey: .trackViewUrl)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(trackId, forKey: .trackId)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(collectionName, forKey: .collectionName)
        try container.encode(trackViewUrl, forKey: .trackViewUrl)
    }
}
