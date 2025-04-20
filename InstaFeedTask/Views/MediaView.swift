//
//  MediaView.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import SwiftUI
import AVKit
import CachedAsyncImage
import Combine

struct MediaView: View {
    let mediaItem: MediaItem
    @State private var player: AVPlayer?
    @State private var isVideoReady = false
    @State private var showError = false
    @State private var isMuted = false
    @State private var cancellables = Set<AnyCancellable>()
    
    @ViewBuilder
    var videoContent: some View {
        if showError {
            errorView
        } else if isVideoReady, let player = player {
            ZStack {
                VideoPlayer(player: player)
                    .onAppear {
                        configureAudioSession()
                        player.isMuted = isMuted
                        player.play()
                    }
                    .onDisappear {
                        cancellables.removeAll()
                        player.pause()
                    }
                
                muteButton
            }
        } else {
            loadingView
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .onAppear { initializePlayer() }
    }
    
    private var errorView: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
            Text("Video unavailable")
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(8)
    }
    
    private var muteButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: { isMuted.toggle() }) {
                    Image(systemName: isMuted ? "speaker.slash" : "speaker")
                        .padding(8)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                        .tint(.white)
                }
                .padding()
            }
        }
    }

    var body: some View {
        Group {
            if mediaItem.type == .image {
                CachedAsyncImage(url: URL(string: mediaItem.url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                videoContent
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .onChange(of: isMuted) {
            player?.isMuted = isMuted
        }
    }
    
    private func initializePlayer() {
        if let url = URL(string: mediaItem.url) {
            setupPlayer(with: AVPlayer(url: url))
        } else {
            showError = true
        }
    }
    
    private func setupPlayer(with player: AVPlayer) {
        self.player = player
        player.isMuted = isMuted
        
        // Observe player's status
        player.publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { status in
                switch status {
                case .readyToPlay:
                    self.isVideoReady = true
                case .failed:
                    self.showError = true
                case .unknown:
                    break
                @unknown default:
                    break
                }
            }
            .store(in: &cancellables)
        
        // Configure looping
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }

    func configureAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(
            .playback,
            mode: .default,
            options: [.mixWithOthers, .duckOthers]
        )
        try? AVAudioSession.sharedInstance().setActive(true)
    }
}
