//
//  SlideInPresentationManager .swift
//  UIPresentationControllerExaple
//
//  Created by Richie Shilton on 17/1/20.
//  Copyright © 2020 Richie Shilton. All rights reserved.
//

import UIKit

class SlideInPresentationManager: NSObject {
    
    let direction: PresentationDirection
    let swipeToDismiss: Bool
    
    init(from direction: PresentationDirection, swipeToDismiss: Bool) {
        self.direction = direction
        self.swipeToDismiss = swipeToDismiss
    }

}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, swipeToDismiss: swipeToDismiss)
      return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}

