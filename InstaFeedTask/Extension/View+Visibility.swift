//
//  View+Visibility.swift
//  InstaFeedTask
//
//  Created by ROBIN HUMNE on 18/04/25.
//

import SwiftUI

extension View {
    func onVisibilityChanged(_ action: @escaping (Bool) -> Void) -> some View {
        self.background(
            GeometryReader { geometry in
                VisibilityTracker(
                    frame: geometry.frame(in: .global),
                    action: action
                )
            }
        )
    }
}

struct VisibilityTracker: UIViewRepresentable {
    let frame: CGRect
    let action: (Bool) -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
            DispatchQueue.main.async {
                // Get all connected window scenes
                let windowScenes = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                
                // Check if the view is visible in any window
                let isVisible = windowScenes.contains { scene in
                    scene.windows.contains { window in
                        window.bounds.intersects(frame) && !window.isHidden
                    }
                }
                
                action(isVisible)
            }
        }
}
