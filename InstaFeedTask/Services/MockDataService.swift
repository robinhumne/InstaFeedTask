//
//  MockDataService.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import Foundation

class MockDataService {
    static let shared = MockDataService()
    private init() {}
    
    func fetchPosts() -> [Post] {
        return [
            Post(
                id: "1",
                username: "nature_lover",
                userAvatar: "https://i.imgur.com/Xv0Ihf4.jpeg",
                location: "Delhi National Park",
                caption: "Beautiful Cat! #nature #animal",
                media: [MediaItem(id: "101", type: .image, url: "https://i.imgur.com/61u0Ksy.jpeg")],
                likes: 320
            ),
            Post(
                id: "2",
                username: "travel_guru",
                userAvatar: "https://i.imgur.com/SPK7YGL.jpeg",
                location: "Tokyo, Japan",
                caption: "Exploring the streets 🗼",
                media: [
                    MediaItem(id: "201", type: .video, url: "https://i.imgur.com/gmlVDEa.mp4"),
                    MediaItem(id: "2-2", type: .image, url: "https://i.imgur.com/MvE3DxU.jpeg")
                ],
                likes: 982
            ),
            Post(
                id: "3",
                username: "foodie_adventures",
                userAvatar: "https://i.imgur.com/Xv0Ihf4.jpeg",
                location: "Rome, Italy",
                caption: "El Duende tax. It's just another normal afternoon. Take care out there!/n #cat #rome",
                media: [MediaItem(id: "301", type: .image, url: "https://i.imgur.com/NT1LIYo.jpeg")],
                likes: 152
            ),
            Post(
                id: "4",
                username: "fitness_motivation",
                userAvatar: "https://i.imgur.com/Xv0Ihf4.jpeg",
                location: "Mumbai, India",
                caption: "When it’s your cats first spring and he hears a bug fly by outside.\n#spring #mumbai #fitness #cat",
                media: [MediaItem(id: "401", type: .video, url: "https://i.imgur.com/WBTSbyL.mp4")],
                likes: 286
            )
        ]
    }
}
