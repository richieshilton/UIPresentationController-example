//
//  SlideInPresentationController.swift
//  UIPresentationControllerExaple
//
//  Created by Richie Shilton on 17/1/20.
//  Copyright © 2020 Richie Shilton. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(recognizer:)))
        view.addGestureRecognizer(recognizer)
        return view
    }()
    
    private var direction: PresentationDirection
    private var swipeInteractionController: SwipeInteractionController?
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection, swipeToDismiss: Bool) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        if swipeToDismiss {
            swipeInteractionController = SwipeInteractionController(viewController: presentedViewController, direction: direction)
        }
    }
    
    @objc func handleBackgroundTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView, let presentedView = presentedView else { return .zero }

        let areaFrame = containerView.bounds//.inset(by: containerView.safeAreaInsets)
        let targetWidth = areaFrame.width
        let fittingSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
        let targetHeight = presentedView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow).height

        var frame = containerView.bounds
        if direction == .bottom {
            frame.origin.y += frame.size.height - targetHeight
        }
        frame.size = CGSize(width: targetWidth, height: targetHeight)
        return frame
    }
}
