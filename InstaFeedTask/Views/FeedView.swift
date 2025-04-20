//
//  FeedView.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.posts) { post in
                        PostView(post: post, viewModel: viewModel)
                            .padding(.bottom, 16)
                    }
                }
            }
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "camera")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "paperplane")
                    }
                }
            }
        }
        .onDisappear {
            viewModel.cleanup()
        }
    }
}

//#Preview {
//    FeedView()
//}
