//
//  SwipeReader.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/20.
//

import SwiftUI
import UIKit

struct SwipeReader<Body: View>: UIViewControllerRepresentable {
    
    private let viewController: UIViewController
    private let coordinator: Coordinator
    private let label: () -> Body
    
    init(label: @escaping () -> Body) {
        viewController = UIHostingController(rootView: label().ignoresSafeArea())
        viewController.view.backgroundColor = .clear
        coordinator = Coordinator()
        self.label = label
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        (uiViewController as? UIHostingController)?.rootView = label().ignoresSafeArea()
    }
    
    class Coordinator {
        var actions = [UInt: (() -> Void)]()
        @objc func onSwipeGesture(gesture: UISwipeGestureRecognizer) {
            actions[gesture.direction.rawValue]?()
        }
    }
    func makeCoordinator() -> Coordinator {
        return coordinator
    }
    func onSwipe(_ direction: UISwipeGestureRecognizer.Direction, action: @escaping () -> Void) -> Self {
        if coordinator.actions[direction.rawValue] == nil {
            let gesture = UISwipeGestureRecognizer(target: coordinator, action: #selector(Coordinator.onSwipeGesture(gesture:)))
            gesture.direction = direction
            viewController.view.addGestureRecognizer(gesture)
        }
        coordinator.actions[direction.rawValue] = action
        return self
    }
}
