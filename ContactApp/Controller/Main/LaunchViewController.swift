//
//  ViewController.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import UIKit

class LaunchViewController: UIViewController {

    private var launchIconAppImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(launchIconAppImageView)
        
        configureLauncIconAppImageView()
        setLaunchIconAppImageViewConstraints()
    }

    private func configureLauncIconAppImageView() {
        launchIconAppImageView.image = Images.appIcon
        launchIconAppImageView.layer.cornerRadius = 225 / 2
    }
    
    private func setLaunchIconAppImageViewConstraints() {
        launchIconAppImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            launchIconAppImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            launchIconAppImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            launchIconAppImageView.widthAnchor.constraint(equalToConstant: 225),
            launchIconAppImageView.heightAnchor.constraint(equalTo: launchIconAppImageView.widthAnchor)
        ])
    }

}

