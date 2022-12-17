//
//  DeleteContactPopVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 16/12/22.
//

import UIKit

class DeleteContactPopVC: UIViewController {

    private let deleteIconImageView: UIImageView = UIImageView()
    private let textLabel1: UILabel = UILabel()
    private let textLabel2: UILabel = UILabel()
    
    private let deleteButton: UIButton = UIButton()
    private let cancelButton: UIButton = UIButton()
    
    private let containerView: UIView = UIView()
    
    
    public func getDeleteButton() -> UIButton {
        return deleteButton
    }
    
    
    public func getCancelButton() -> UIButton {
        return cancelButton
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x808080, alpha: 0.5)
        
        self.definesPresentationContext = true
        view.addSubview(containerView)
        
        containerView.addSubview(deleteIconImageView)
        containerView.addSubview(textLabel1)
        containerView.addSubview(textLabel2)
        containerView.addSubview(deleteButton)
        containerView.addSubview(cancelButton)
        
        configureDeleteIconImageView()
        configureLabels()
        configureButtons()
        
        configureContactInfoView()

        setDeleteIconImageViewConstraints()
        setTextLabel1Constraints()
        setTextLabel2Constraints()
        setDeleteButtonConstraints()
        setCancelButtonConstraints()
        
        setContainerViewConstraints()
    }

    
    private func configureDeleteIconImageView() {
        deleteIconImageView.image = Images.dustbin
        deleteIconImageView.layer.cornerRadius = 50 / 2
        deleteIconImageView.clipsToBounds = true
    }
    
    private func configureLabels() {
        textLabel1.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        textLabel1.font = .boldSystemFont(ofSize: 15)
        textLabel1.textAlignment = .center
        textLabel1.text = "Are you sure ?"
        
        textLabel2.setDefaultConfigurations(withFontSize: 12, adjustsFontSizeToFitWidth: true)
        textLabel2.font = .boldSystemFont(ofSize: 12)
        textLabel2.textAlignment = .center
        textLabel2.text = "Do you want to delete this contact ?"
    }
    
    private func configureButtons() {
        deleteButton.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0xDE0000)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.setTitleColor(.lightGray, for: .highlighted)
        deleteButton.layer.cornerRadius = 5
        
        cancelButton.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0xD9D9D9)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitleColor(.lightGray, for: .highlighted)
        cancelButton.layer.cornerRadius = 5
        
        cancelButton.addTarget(self, action: #selector(onCancelButtonClick), for: .touchUpInside)
    }

    
    private func configureContactInfoView() {
        containerView.backgroundColor = .white
    }
    
    
    private func setDeleteIconImageViewConstraints() {
        deleteIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteIconImageView.widthAnchor.constraint(equalToConstant: 50),
            deleteIconImageView.heightAnchor.constraint(equalTo: deleteIconImageView.widthAnchor),
            deleteIconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            deleteIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func setTextLabel1Constraints(){
        textLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel1.centerXAnchor.constraint(equalTo: deleteIconImageView.centerXAnchor),
            textLabel1.topAnchor.constraint(equalTo: deleteIconImageView.bottomAnchor, constant: 5),
            textLabel1.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    private func setTextLabel2Constraints(){
        textLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel2.centerXAnchor.constraint(equalTo: deleteIconImageView.centerXAnchor),
            textLabel2.topAnchor.constraint(equalTo: textLabel1.bottomAnchor, constant: 5),
            textLabel2.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func setDeleteButtonConstraints(){
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 78),
            deleteButton.heightAnchor.constraint(equalToConstant: 27),
            deleteButton.topAnchor.constraint(equalTo: textLabel2.bottomAnchor, constant: 15),
            deleteButton.trailingAnchor.constraint(equalTo: deleteIconImageView.centerXAnchor, constant: -14.5),
            deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14)
        ])
    }
    
    private func setCancelButtonConstraints(){
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.widthAnchor.constraint(equalToConstant: 78),
            cancelButton.heightAnchor.constraint(equalToConstant: 27),
            cancelButton.topAnchor.constraint(equalTo: textLabel2.bottomAnchor, constant: 15),
            cancelButton.leadingAnchor.constraint(equalTo: deleteIconImageView.centerXAnchor, constant: 14.5),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14)
        ])
    }
    
    
    private func setContainerViewConstraints(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
//            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

extension DeleteContactPopVC {
    
    @objc private func onCancelButtonClick() {
        dismiss(animated: true)
    }
    
}
