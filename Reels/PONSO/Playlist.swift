//
//  Playlist.swift
//  Reels
//
//  Created by Hassan on 29/07/2022.
//

import Foundation


// MARK: - Welcome
struct PlaylistModel: Codable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let snippet: Snippet?
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String?
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle, playlistID: String?
    let position: Int?
    let resourceID: ResourceID?
    let videoOwnerChannelTitle, videoOwnerChannelID: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
        case videoOwnerChannelTitle
        case videoOwnerChannelID = "videoOwnerChannelId"
    }
}

// MARK: - ResourceID
struct ResourceID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?
    let standard, maxres: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
