//
//  ContactInfoCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class ContactInfoContainerCell: UITableViewCell {

    public static let cellIdentifier = "ContactInfoContainerCell"
    
    
    private let contactInfoLabel: UILabel = UILabel()
    private let mobileLabel: UILabel = UILabel()
    private let nameLabel: UILabel = UILabel()
    private let emailLabel: UILabel = UILabel()
    private let dateOfBirthLabel: UILabel = UILabel()
    
    private let mobileValueLabel: UILabel = UILabel()
    private let nameValueLabel: UILabel = UILabel()
    private let emailValueLabel: UILabel = UILabel()
    private let dateOfBirthValueLabel: UILabel = UILabel()
    
    private let contactInfoView: UIView = UIView()
    
    
    public func setCellContext(mobileNo: String, name: String, email: String, dateOfBirth: String) {
        mobileValueLabel.text = mobileNo
        nameValueLabel.text = name
        emailValueLabel.text = email
        dateOfBirthValueLabel.text = dateOfBirth
    }
    
    public func setCellContext(with model: ContactInfoContainerModel) {
        mobileValueLabel.text = model.mobileNo
        nameValueLabel.text = model.name
        emailValueLabel.text = model.email
        dateOfBirthValueLabel.text = model.dateOfBirth
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(contactInfoView)
        contactInfoView.addSubview(contactInfoLabel)

        contactInfoView.addSubview(mobileLabel)
        contactInfoView.addSubview(mobileValueLabel)

        contactInfoView.addSubview(nameLabel)
        contactInfoView.addSubview(nameValueLabel)

        contactInfoView.addSubview(emailLabel)
        contactInfoView.addSubview(emailValueLabel)

        contactInfoView.addSubview(dateOfBirthLabel)
        contactInfoView.addSubview(dateOfBirthValueLabel)
        
        configureContactInfoView()
        configureLabels()

        setContactInfoViewConstraints()

        setContactInfoLabelConstraints()
        setMobileLabelConstraints()
        setMobileValueLabel()
        setNameLabelConstraints()
        setNameValueLabelConstraints()
        setEmailLabelConstraints()
        setEmailValueLabelConstraints()
        setDateOfBirthLabelConstraints()
        setDateOfBirthValueLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureContactInfoView() {
        contactInfoView.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0xf3f9ff, alpha: 1)
        contactInfoView.layer.cornerRadius = 7
    }
    
    private func configureLabels() {
        contactInfoLabel.setDefaultConfigurations(withFontSize: 16, adjustsFontSizeToFitWidth: true)
        contactInfoLabel.font =  UIFont.boldSystemFont(ofSize: 16)
        contactInfoLabel.text = "Contact Info"
        
        mobileLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        mobileLabel.text = "Mobile"
        
        mobileValueLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        
        nameLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        nameLabel.text = "Name"
        
        nameValueLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        
        emailLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        emailLabel.text = "Email"
        
        emailValueLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        
        dateOfBirthLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        dateOfBirthLabel.text = "Date of Birth"
        
        dateOfBirthValueLabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
    }
    
    
    
    private func setContactInfoViewConstraints() {
        contactInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            contactInfoView.widthAnchor.constraint(equalToConstant: 330),
//            contactInfoView.heightAnchor.constraint(equalToConstant: 258),
            contactInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contactInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
//            contactInfoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contactInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contactInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setContactInfoLabelConstraints() {
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactInfoLabel.widthAnchor.constraint(equalToConstant: 89),
            contactInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            contactInfoLabel.topAnchor.constraint(equalTo: contactInfoView.topAnchor, constant: 20),
            contactInfoLabel.leadingAnchor.constraint(equalTo: contactInfoView.leadingAnchor, constant: 20),
//            contactInfoLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -221)
        ])
    }
    
    private func setMobileLabelConstraints() {
        mobileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mobileLabel.widthAnchor.constraint(equalToConstant: 87),
            mobileLabel.heightAnchor.constraint(equalToConstant: 19),
            mobileLabel.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
            mobileLabel.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            mobileLabel.trailingAnchor.constraint(equalTo: mobileValueLabel.leadingAnchor, constant: -35)
        ])
    }
    
    private func setMobileValueLabel() {
        mobileValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mobileValueLabel.firstBaselineAnchor.constraint(equalTo: mobileLabel.firstBaselineAnchor),
//            mobileValueLabel.leadingAnchor.constraint(equalTo: mobileLabel.leadingAnchor, constant: 77),
//            mobileValueLabel.widthAnchor.constraint(equalToConstant: 168),
            mobileValueLabel.heightAnchor.constraint(equalToConstant: 19),
            mobileValueLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mobileLabel.bottomAnchor, constant: 34),
            nameLabel.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mobileLabel.trailingAnchor)
        ])
    }
    
    private func setNameValueLabelConstraints() {
        nameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameValueLabel.topAnchor.constraint(equalTo: mobileValueLabel.bottomAnchor, constant: 34),
            nameValueLabel.leadingAnchor.constraint(equalTo: mobileValueLabel.leadingAnchor),
            nameValueLabel.trailingAnchor.constraint(equalTo: mobileValueLabel.trailingAnchor)
        ])
    }
    
    private func setEmailLabelConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            emailLabel.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: mobileLabel.trailingAnchor)
        ])
    }
    
    private func setEmailValueLabelConstraints() {
        emailValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailValueLabel.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor, constant: 32),
            emailValueLabel.leadingAnchor.constraint(equalTo: mobileValueLabel.leadingAnchor),
            emailValueLabel.trailingAnchor.constraint(equalTo: mobileValueLabel.trailingAnchor)
        ])
    }
    
    private func setDateOfBirthLabelConstraints() {
        dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateOfBirthLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 34),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: contactInfoLabel.leadingAnchor),
            dateOfBirthLabel.trailingAnchor.constraint(equalTo: mobileLabel.trailingAnchor),
            dateOfBirthLabel.bottomAnchor.constraint(equalTo: contactInfoView.bottomAnchor, constant: -22)
        ])
    }
    
    private func setDateOfBirthValueLabelConstraints() {
        dateOfBirthValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateOfBirthValueLabel.heightAnchor.constraint(equalToConstant: 19),
            dateOfBirthValueLabel.topAnchor.constraint(equalTo: emailValueLabel.bottomAnchor, constant: 34),
            dateOfBirthValueLabel.leadingAnchor.constraint(equalTo: mobileValueLabel.leadingAnchor),
            dateOfBirthValueLabel.trailingAnchor.constraint(equalTo: mobileValueLabel.trailingAnchor),
            dateOfBirthValueLabel.bottomAnchor.constraint(equalTo: contactInfoView.bottomAnchor, constant: -22)
        ])
    }
    
    
}
