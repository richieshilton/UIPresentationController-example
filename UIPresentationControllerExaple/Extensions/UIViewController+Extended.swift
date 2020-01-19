//
//  UIViewController+Extended.swift
//  UIPresentationControllerExaple
//
//  Created by Richie Shilton on 17/1/20.
//  Copyright © 2020 Richie Shilton. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func present(_ vc: UIViewController, with transitioningDelegate: UIViewControllerTransitioningDelegate) {
        vc.transitioningDelegate = transitioningDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
}

