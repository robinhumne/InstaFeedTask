//
//  FeedViewModel.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import Foundation
import AVKit

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    // Video players cache
    private var videoPlayers: [String: AVPlayer] = [:]
    
    init() {
        loadPosts()
    }
    
    func loadPosts() {
        self.posts = MockDataService.shared.fetchPosts()
    }
    
    func getVideoPlayer(for mediaItem: MediaItem) -> AVPlayer {
        if let player = videoPlayers[mediaItem.id] {
            return player
        }
        
        if let url = URL(string: mediaItem.url) {
            let player = AVPlayer(url: url)
            videoPlayers[mediaItem.id] = player
            return player
        }
        return AVPlayer()
    }
    
    func cleanup() {
        videoPlayers.values.forEach { player in
            player.pause()
            player.replaceCurrentItem(with: nil)
        }
        videoPlayers.removeAll()
    }
}
