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
    
    private let containerView: UIView = UIView()
    
    public func getCallButton() -> UIButton {
        return callButton
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(contactImageView)
        containerView.addSubview(contactNameLabel)
        containerView.addSubview(contactNumberlabel)
        containerView.addSubview(callButton)
        
        
        configureImageViews()
        configureLabels()
        configureCallButton()
        
        setContainerViewConstraints()
        
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
    
    private func configureCallButton() {
        callButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
    }
    
    
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        containerView.pin(to: contentView)
    }
    
    
    
    private func setContactImageViewConstraints() {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            contactImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12.0),
            contactImageView.widthAnchor.constraint(equalToConstant: 80),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor)
        ])
    }
    
    private func setContactNameLabelConstraints() {
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactNameLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        NSLayoutConstraint.activate([
//            contactNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
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
            callButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            callButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            callButton.widthAnchor.constraint(equalToConstant: 40),
            callButton.heightAnchor.constraint(equalTo: callButton.widthAnchor)
        ])
    }

}

extension ContactInfoCell {
    @objc private func callNumber() {
        
        guard let contactNo = self.contactNumberlabel.text else { return }
        
        CallAPIWrapper.makePhoneCall(contactNumber: contactNo)
        
    }
}
