//
//  ContactInfoCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    public static let cellHeight = 100.0
    public static let cellIdentifier = "ContactInfoCell"
    
    private var contactImageView: UIImageView = UIImageView()
    private var contactNameLabel: UILabel = UILabel()
    private var contactNumberlabel: UILabel = UILabel()
    private var callButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(Images.callButton, for: .normal)
        
        return button
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(contactImageView)
        self.addSubview(contactNameLabel)
        self.addSubview(contactNumberlabel)
        self.addSubview(callButton)
        
        
        configureImageViews()
        configureLabels()
        
        setContactImageViewConstraints()
        setContactNameLabelConstraints()
        setContactNumberLabelConstraints()
        setCallButtonLabelContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(contactImage: UIImage, contactNameLabel: String, contactNumberlabel: String) {
        self.contactImageView.image  = contactImage
        self.contactNameLabel.text   = contactNameLabel
        self.contactNumberlabel.text = contactNumberlabel
    }
    
    private func configureImageViews() {
        contactImageView.layer.cornerRadius = 40
        contactImageView.clipsToBounds = true
    }
    
    private func configureLabels() {
        contactNameLabel.numberOfLines = 0
        contactNameLabel.adjustsFontSizeToFitWidth = true
        contactNameLabel.font = contactNameLabel.font.withSize(18)
        
        contactNumberlabel.numberOfLines = 0
        contactNumberlabel.adjustsFontSizeToFitWidth = true
        contactNumberlabel.font = contactNumberlabel.font.withSize(18)
    }
    
    private func setContactImageViewConstraints() {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.0),
            contactImageView.widthAnchor.constraint(equalToConstant: 80),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor)
        ])
    }
    
    private func setContactNameLabelConstraints() {
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactNameLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        NSLayoutConstraint.activate([
//            contactNameLabel.firstBaselineAnchor.constraint(equalTo: contactImageView.firstBaselineAnchor, constant: 20),
            contactNameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 40.0),
            contactNameLabel.trailingAnchor.constraint(equalTo: callButton.leadingAnchor, constant: 40),
            contactNameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setContactNumberLabelConstraints() {
        contactNumberlabel.translatesAutoresizingMaskIntoConstraints = false
        contactNumberlabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        NSLayoutConstraint.activate([
            contactNumberlabel.topAnchor.constraint(equalTo: contactNameLabel.bottomAnchor, constant: 5),
            contactNumberlabel.leadingAnchor.constraint(equalTo: contactNameLabel.leadingAnchor),
            contactNumberlabel.trailingAnchor.constraint(equalTo: contactNameLabel.trailingAnchor),
            contactNumberlabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setCallButtonLabelContraints() {
        callButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            callButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            callButton.leadingAnchor.constraint(equalTo: contactNameLabel.trailingAnchor),
            callButton.widthAnchor.constraint(equalToConstant: 40),
            callButton.heightAnchor.constraint(equalTo: callButton.widthAnchor)
        ])
    }

}
