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
            let visible = UIApplication.shared.windows.contains { window in
                window.bounds.intersects(frame)
            }
            action(visible)
        }
    }
}
