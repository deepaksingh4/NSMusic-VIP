//
//  MusicResponse.swift
//  NGMusic
//
//  Created by Deepak on 04/08/22.
//

import Foundation

struct SearchResultResponseModel: Codable {
    let resultCount: Int?
    let results: [MusicResponseModel]?

    enum CodingKeys: String, CodingKey {

        case resultCount
        case results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([MusicResponseModel].self, forKey: .results)
    }
}

struct MusicResponseModel: Codable {
    public let trackName: String?
    public let artistName: String
    public let artistViewUrl: URL?
    public let artworkUrl100: URL?
    public let collectionName: String?
    public let wrapperType: ITunesSearchResultType
    public let kind: String?
    public let collectionPrice: Double?
    public let copyright: String?
    public let country: String?
    public let currency: String?
    public let releaseDate: String?
    public let previewUrl: URL?
    public let collectionViewUrl: URL?

}

extension MusicResponseModel {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
        artistName = try container.decode(String.self, forKey: .artistName)
        artistViewUrl = try container.decodeIfPresent(URL.self, forKey: .artistViewUrl) ?? nil
        artworkUrl100 = try container.decodeIfPresent(URL.self, forKey: .artworkUrl100) ?? nil
        wrapperType = try container.decode(ITunesSearchResultType.self, forKey: .wrapperType)
        collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName) ?? nil
        kind = try container.decodeIfPresent(String.self, forKey: .kind) ?? nil

        collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice) ?? 0.0
        copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        previewUrl = try container.decodeIfPresent(URL.self, forKey: .previewUrl) ?? nil
        collectionViewUrl = try container.decodeIfPresent(URL.self, forKey: .collectionViewUrl) ?? nil
    }
}

public enum ITunesSearchResultType: String, Codable {
    case track, collection, artist, audiobook, album, allArtist, movie, musicVideo, podcast, song
}

enum MediaType: String, CaseIterable, Codable {
    case album = "Album"
    case artist = "Artist"
    case book = "Book"
    case movie = "Movie"
    case musicVideo = "Music Video"
    case podcast = "Podcast"
    case song = "Song"

    var key: String {
        switch self {
        case .album:
            return "album"
        case .artist:
            return "allArtist"
        case .book:
            return "audiobook"
        case .movie:
            return "movie"
        case .musicVideo:
            return "musicVideo"
        case .podcast:
            return "podcast"
        case .song:
            return "song"
        }
    }
}
