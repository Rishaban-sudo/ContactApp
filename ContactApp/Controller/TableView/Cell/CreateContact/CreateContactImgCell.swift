//
//  CreateContactImgCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class CreateContactImgCell: UITableViewCell {

    public static let cellIdentifier = "CreateContactImgCell"
    
    private let contactImageButton: UIButton = UIButton()
    private let containerView: UIView = UIView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(contactImageButton)
        
        configureContactImageView()
        
        setContactImageButtonConstraints()
        setContainerViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func setContactImage(contactImage: UIImage?) {
        contactImageButton.setBackgroundImage(contactImage, for: .normal)
    }
    
    
    public func getContactImgButton() -> UIButton {
        return contactImageButton
    }
    
    
    
    
    
    private func configureContactImageView() {
        contactImageButton.layer.cornerRadius = 100 / 2
        contactImageButton.clipsToBounds = true
    }
    
    
    
    private func setContactImageButtonConstraints() {
        contactImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImageButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            contactImageButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            contactImageButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -19),
            contactImageButton.widthAnchor.constraint(equalToConstant: 100),
            contactImageButton.heightAnchor.constraint(equalTo: contactImageButton.widthAnchor)
        ])
    }
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pin(to: contentView)
    }

}
