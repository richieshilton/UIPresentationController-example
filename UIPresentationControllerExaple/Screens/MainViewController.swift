//
//  MainViewController.swift
//  UIPresentationControllerExaple
//
//  Created by Richie Shilton on 17/1/20.
//  Copyright © 2020 Richie Shilton. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var vcHeight: Float = 400
    let topSlideInTransitioningDelegate = SlideInPresentationManager(from: .top, swipeToDismiss: true)
    let bottomSlideInTransitioningDelegate = SlideInPresentationManager(from: .bottom, swipeToDismiss: true)
    
    let topButton: UIButton = {
        let button = UIButton()
        button.setTitle("TOP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomButton: UIButton = {
        let button = UIButton()
        button.setTitle("BOTTOM", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 200
        slider.maximumValue = 600
        slider.isContinuous = false
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .gray
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [topButton, bottomButton, slider].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            topButton.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            topButton.topAnchor.constraint(equalTo: view.topAnchor),
            topButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButton.topAnchor.constraint(equalTo: view.centerYAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        topButton.addTarget(self, action: #selector(top), for: .touchUpInside)
        bottomButton.addTarget(self, action: #selector(bottom), for: .touchUpInside)
        
        slider.value = vcHeight
        slider.addTarget(self, action: #selector(slid), for: .valueChanged)
    }
    
    @objc func top() {
        let vc = SecondViewController()
        vc.height = CGFloat(exactly: floor(vcHeight)) ?? 0
        present(vc, with: topSlideInTransitioningDelegate)
    }
    
    @objc func bottom() {
        let vc = SecondViewController()
        vc.height = CGFloat(exactly: floor(vcHeight)) ?? 0
        present(vc, with: bottomSlideInTransitioningDelegate)
    }
    
    @objc func slid() {
        vcHeight = slider.value
    }
}
