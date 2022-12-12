//
//  IndividualContactVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 09/12/22.
//

import UIKit

class IndividualContactVC: UIViewController {

    private let contactImageView: UIImageView = UIImageView()
    private let contactNameLabel: UILabel = UILabel()
    private let contactNumberlabel: UILabel = UILabel()
    private let callButton: UIButton = UIButton()
    private let horizontalSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        return separator
    } ()
    
    private let imgContainer: UILayoutGuide = UILayoutGuide()
    
    
    
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
    private let contactInfoContainer: UILayoutGuide = UILayoutGuide()
    
    
    private let notesContainer: UILayoutGuide = UILayoutGuide()
    
    
    private var margins: UILayoutGuide!
    
    
    public func setValues(contactImage: UIImage, contactName: String, contactNumber: String) {
        contactImageView.image     = contactImage
        contactNameLabel.text      = contactName
        contactNumberlabel.text    = contactNumber
        
        
        mobileValueLabel.text      = contactNumber
        nameValueLabel.text        = contactName
        //to add email and dob to model class and to get from table cell
        emailValueLabel.text       = "rishaban.ss@zohocorp.com"
        dateOfBirthValueLabel.text = "05/08/2000"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        margins = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        view.addSubview(contactImageView)
        view.addSubview(contactNameLabel)
        view.addSubview(contactNumberlabel)
        view.addSubview(callButton)
        view.addSubview(horizontalSeparator)
        
        view.addLayoutGuide(imgContainer)
        
        view.addSubview(contactInfoView)
        contactInfoView.addSubview(contactInfoLabel) //
        
        contactInfoView.addSubview(mobileLabel)
        contactInfoView.addSubview(mobileValueLabel)
        
        contactInfoView.addSubview(nameLabel)
        contactInfoView.addSubview(nameValueLabel)
        
        contactInfoView.addSubview(emailLabel)
        contactInfoView.addSubview(emailValueLabel)
        
        contactInfoView.addSubview(dateOfBirthLabel)
        contactInfoView.addSubview(dateOfBirthValueLabel)
        
        
        configureContactImageView()
        configureLabels()
        configureCallButton()
        
        setContactImageViewConstraints()
        setContactNameLabelConstraints()
        setContactNumberLabelConstraints()
        setCallButtonConstraints()
        setHorizontalSeparatorConstraints()
        
        setImgContainerConstraints()
        
        
        
        configureContactInfoView()
        
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
        
//        setContactInfoContainerConstraints()
    }
    
    
    private func configureContactImageView() {
        contactImageView.layer.cornerRadius = 100 / 2
        contactImageView.clipsToBounds = true
    }
    
    private func configureLabels() {
        contactNameLabel.numberOfLines = 0
        contactNameLabel.adjustsFontSizeToFitWidth = true
        contactNameLabel.font = contactNameLabel.font.withSize(18)
        contactNameLabel.textAlignment = .center
        
        contactNumberlabel.numberOfLines = 0
        contactNumberlabel.adjustsFontSizeToFitWidth = true
        contactNumberlabel.font = contactNumberlabel.font.withSize(18)
        contactNumberlabel.textAlignment = .center
        
        
        contactInfoLabel.setDefaultConfigurations(withFontSize: 16)
        contactInfoLabel.text = "Contact Info"
        
        mobileLabel.setDefaultConfigurations(withFontSize: 15)
        mobileLabel.text = "Mobile"
        
        mobileValueLabel.setDefaultConfigurations(withFontSize: 15)
        
        nameLabel.setDefaultConfigurations(withFontSize: 15)
        nameLabel.text = "Name"
        
        nameValueLabel.setDefaultConfigurations(withFontSize: 15)
        
        emailLabel.setDefaultConfigurations(withFontSize: 15)
        emailLabel.text = "Email"
        
        emailValueLabel.setDefaultConfigurations(withFontSize: 15)
        
        dateOfBirthLabel.setDefaultConfigurations(withFontSize: 15)
        dateOfBirthLabel.text = "Date of Birth"
        
        dateOfBirthValueLabel.setDefaultConfigurations(withFontSize: 15)
    }
    
    private func configureCallButton() {
        callButton.backgroundColor = .systemGreen
        callButton.setTitle("Call", for: .normal)
        callButton.setTitleColor(.white, for: .normal)
        callButton.setTitleColor(.lightGray, for: .highlighted)
        callButton.layer.cornerRadius = 5
    }
    
    
    private func setContactImageViewConstraints() {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImageView.centerXAnchor.constraint(equalTo: imgContainer.centerXAnchor),
            contactImageView.topAnchor.constraint(equalTo: imgContainer.topAnchor, constant: 20),
            contactImageView.widthAnchor.constraint(equalToConstant: 100),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor)
        ])
    }
    
    private func setContactNameLabelConstraints() {
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactNameLabel.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 16),
            contactNameLabel.centerXAnchor.constraint(equalTo: contactImageView.centerXAnchor),
            contactNameLabel.widthAnchor.constraint(equalToConstant: 135)
        ])
    }
    
    private func setContactNumberLabelConstraints() {
        contactNumberlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactNumberlabel.topAnchor.constraint(equalTo: contactNameLabel.topAnchor, constant: 30),
            contactNumberlabel.centerXAnchor.constraint(equalTo: contactImageView.centerXAnchor),
            contactNumberlabel.widthAnchor.constraint(equalToConstant: 145)
        ])
    }
    
    private func setCallButtonConstraints() {
        callButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callButton.heightAnchor.constraint(equalToConstant: 40),
            callButton.widthAnchor.constraint(equalToConstant: 129),
            callButton.centerXAnchor.constraint(equalTo: contactImageView.centerXAnchor),
            callButton.topAnchor.constraint(equalTo: contactNumberlabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func setHorizontalSeparatorConstraints() {
        horizontalSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalSeparator.heightAnchor.constraint(equalToConstant: 1),
            horizontalSeparator.widthAnchor.constraint(equalTo: view.widthAnchor),
            horizontalSeparator.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setImgContainerConstraints() {
        NSLayoutConstraint.activate([
            imgContainer.topAnchor.constraint(equalTo: margins.topAnchor),
            imgContainer.heightAnchor.constraint(equalToConstant: 100),
            imgContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            imgContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
    
    
    
    
    
    
    private func configureContactInfoView() {
        contactInfoView.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0xf3f9ff, alpha: 1)
        contactInfoView.layer.cornerRadius = 7
    }
    
    private func setContactInfoViewConstraints() {
        contactInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactInfoView.widthAnchor.constraint(equalToConstant: 330),
            contactInfoView.heightAnchor.constraint(equalToConstant: 258),
            contactInfoView.centerXAnchor.constraint(equalTo: imgContainer.centerXAnchor),
//            contactInfoView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
//            contactInfoView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            contactInfoView.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor, constant: 20)
        ])
    }
    
    private func setContactInfoLabelConstraints() {
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactInfoLabel.widthAnchor.constraint(equalToConstant: 89),
            contactInfoLabel.heightAnchor.constraint(equalToConstant: 20),
            contactInfoLabel.topAnchor.constraint(equalTo: contactInfoView.topAnchor, constant: 20),
            contactInfoLabel.leadingAnchor.constraint(equalTo: contactInfoView.leadingAnchor, constant: 20),
            contactInfoLabel.trailingAnchor.constraint(equalTo: contactInfoView.trailingAnchor, constant: -221)
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
            mobileValueLabel.topAnchor.constraint(equalTo: contactInfoView.topAnchor, constant: 60),
            mobileValueLabel.widthAnchor.constraint(equalToConstant: 168),
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
