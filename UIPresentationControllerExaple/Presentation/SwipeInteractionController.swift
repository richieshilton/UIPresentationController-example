//
//  SwipeInteractionController.swift
//  UIPresentationControllerExaple
//
//  Created by Richie Shilton on 17/1/20.
//  Copyright © 2020 Richie Shilton. All rights reserved.
//

import UIKit

class SwipeInteractionController {

    private let viewController: UIViewController
    private let direction: PresentationDirection

    init(viewController: UIViewController, direction: PresentationDirection) {
        self.direction = direction
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        switch direction {
        case .top:      gesture.direction = .up
        case .bottom:   gesture.direction = .down
        }
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        viewController.dismiss(animated: true)
    }
}
