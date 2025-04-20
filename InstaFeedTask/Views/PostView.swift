//
//  PostView.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import SwiftUI
import CachedAsyncImage

struct PostView: View {
    let post: Post
    @ObservedObject var viewModel: FeedViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // User
            HStack {
                CachedAsyncImage(url: URL(string: post.userAvatar)) { phase in
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
                .frame(width: 40, height: 40)
                .scaledToFill()
                .clipShape(Circle())
                .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text(post.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    if let location = post.location {
                        Text(location)
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .tint(.black)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            
            // Media
            ForEach(post.media) { mediaItem in
                MediaView(mediaItem: mediaItem)
                    .frame(height: 300)
                    .padding(.vertical, 10)
                    .onVisibilityChanged { visible in
                        if mediaItem.type == .video {
                            if visible {
                                viewModel.getVideoPlayer(for: mediaItem).play()
                            } else {
                                viewModel.getVideoPlayer(for: mediaItem).pause()
                            }
                        }
                    }
            }
            
            // Likes
            Text("\(post.likes) likes")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.bottom, 2)
            
            // Caption
            if let caption = post.caption {
                VStack(alignment: .leading, spacing: 4) {
                    Text(post.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(caption)
                        .font(.subheadline)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 6)
            }
        }
    }
}
