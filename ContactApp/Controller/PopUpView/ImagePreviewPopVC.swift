//
//  ImagePreviewPopVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 19/12/22.
//

import UIKit

class ImagePreviewPopVC: UIViewController {

    private let imagePreview: UIImageView = UIImageView()
    private let closeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemOrange, for: .highlighted)
        button.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x808080, alpha: 0.5)
        
        
        return button
    } ()
    private let containerView: UIView = UIView()
    
    
    public func setImagePreview(with image: UIImage) {
        self.imagePreview.image = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x808080, alpha: 0.5)
        
        self.definesPresentationContext = true
        
        view.addSubview(containerView)
        containerView.addSubview(imagePreview)
        containerView.addSubview(closeButton)
        
        configureContainerView()
        configureCloseButton()
        configureImagePreview()
        
        setImagePreviewConstraints()
        setCloseButtonConstraints()
        setContainerViewConstraints()
    }
    
    
    private func configureContainerView() {
        containerView.backgroundColor = .white
    }
    
    
    private func configureCloseButton() {
        closeButton.addTarget(self, action: #selector(onCloseButtonTap), for: .touchUpInside)
    }
    
    private func configureImagePreview() {
        imagePreview.contentMode = .scaleAspectFit
        imagePreview.layer.cornerRadius = 5
    }
    
    
    private func setImagePreviewConstraints() {
        imagePreview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePreview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            imagePreview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            imagePreview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            imagePreview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
        ])
    }
    
    private func setCloseButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14)
        ])
    }
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}


extension ImagePreviewPopVC {
    
    @objc private func onCloseButtonTap() {
        dismiss(animated: true)
    }
    
}
