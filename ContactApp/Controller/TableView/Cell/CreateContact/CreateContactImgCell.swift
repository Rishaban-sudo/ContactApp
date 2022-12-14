//
//  CreateContactImgCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class CreateContactImgCell: UITableViewCell {

    public static let cellIdentifier = "CreateContactImgCell"
    
    private let contactImageView: UIImageView = UIImageView()
    private let containerView: UIView = UIView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(contactImageView)
        
        configureContactImageView()
        
        setContactImageViewConstraints()
        setContainerViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureContactImageView() {
        contactImageView.image = Images.dummyContactImage
        contactImageView.layer.cornerRadius = 100 / 2
        contactImageView.clipsToBounds = true
    }
    
    
    
    private func setContactImageViewConstraints() {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            contactImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            contactImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -19),
            contactImageView.widthAnchor.constraint(equalToConstant: 100),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor)
        ])
    }
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pin(to: contentView)
    }

}
