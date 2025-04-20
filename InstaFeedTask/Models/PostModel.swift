//
//  PostModel.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import Foundation

enum MediaType: String, Codable {
    case image
    case video
}

struct MediaItem: Identifiable, Codable {
    let id: String
    let type: MediaType
    let url: String
}

struct Post: Identifiable, Codable {
    let id: String
    let username: String
    let userAvatar: String
    let location: String?
    let caption: String?
    let media: [MediaItem]
    let likes: Int
}
