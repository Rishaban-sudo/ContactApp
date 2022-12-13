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
    
    
    private let notesLabel: UILabel = UILabel()
    private let notesLabelValue: UILabel = UILabel()
    
    private let notesView: UIView = UIView()
    
    
    private var margins: UILayoutGuide!
    
    
    public func setValues(contactImage: UIImage,
                          contactName: String,
                          contactNumber: String,
                          email: String,
                          dateOfBirth: String) {
        
        contactImageView.image     = contactImage
        contactNameLabel.text      = contactName
        contactNumberlabel.text    = contactNumber
        
        
        mobileValueLabel.text      = contactNumber
        nameValueLabel.text        = contactName
        
        emailValueLabel.text       = email
        dateOfBirthValueLabel.text = dateOfBirth
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Delete", style: .plain, target: self, action: nil),
                                              UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)]
        
        margins = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        view.addSubview(contactImageView)
        view.addSubview(contactNameLabel)
        view.addSubview(contactNumberlabel)
        view.addSubview(callButton)
        view.addSubview(horizontalSeparator)
        
        view.addLayoutGuide(imgContainer)
        
        view.addSubview(contactInfoView)
        contactInfoView.addSubview(contactInfoLabel)
        
        contactInfoView.addSubview(mobileLabel)
        contactInfoView.addSubview(mobileValueLabel)
        
        contactInfoView.addSubview(nameLabel)
        contactInfoView.addSubview(nameValueLabel)
        
        contactInfoView.addSubview(emailLabel)
        contactInfoView.addSubview(emailValueLabel)
        
        contactInfoView.addSubview(dateOfBirthLabel)
        contactInfoView.addSubview(dateOfBirthValueLabel)
        
        view.addSubview(notesView)
        
        notesView.addSubview(notesLabel)
        notesView.addSubview(notesLabelValue)
        
        
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
        

        
        configureNotesView()
        
        setNotesViewConstraints()
        
        setNotesLabelConstraints()
        setNotesLabelValueConstraints()
    }
    
    
    private func configureContactImageView() {
        contactImageView.layer.cornerRadius = 100 / 2
        contactImageView.clipsToBounds = true
    }
    
    private func configureLabels() {
        contactNameLabel.setDefaultConfigurations(withFontSize: 18, adjustsFontSizeToFitWidth: true)
        contactNameLabel.textAlignment = .center
        
        contactNumberlabel.setDefaultConfigurations(withFontSize: 18, adjustsFontSizeToFitWidth: true)
        contactNumberlabel.textAlignment = .center
        
        
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
        
        notesLabel.setDefaultConfigurations(withFontSize: 16, adjustsFontSizeToFitWidth: true)
        notesLabel.font =  UIFont.boldSystemFont(ofSize: 16)
        notesLabel.text = "Notes"
        
        notesLabelValue.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: false)
        notesLabelValue.text = "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint jdbdhvwdhvbdk,.cd.dvfs avahc dolor do amet sint jdbdhvwdhvbdk,.cd.dvfs klwcjbdvsghcvjkfldkg fbd slosiougfcutgjklgfcdgxcfvjkl sdyvbksfjhgv "
    }
    
    private func configureCallButton() {
        callButton.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x00AB00)
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
            mobileValueLabel.firstBaselineAnchor.constraint(equalTo: mobileLabel.firstBaselineAnchor),
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
    
    
    
    
    
    
    private func configureNotesView() {
        notesView.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0xf3f9ff, alpha: 1)
        notesView.layer.cornerRadius = 7
    }
    
    private func setNotesViewConstraints() {
        notesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesView.widthAnchor.constraint(equalToConstant: 330),
//            notesView.heightAnchor.constraint(equalToConstant: 120),
            notesView.centerXAnchor.constraint(equalTo: imgContainer.centerXAnchor),
            notesView.topAnchor.constraint(equalTo: contactInfoView.bottomAnchor, constant: 12)
        ])
    }
    
    private func setNotesLabelConstraints() {
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesLabel.widthAnchor.constraint(equalToConstant: 42),
            notesLabel.heightAnchor.constraint(equalToConstant: 20),
            notesLabel.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 20),
            notesLabel.topAnchor.constraint(equalTo: notesView.topAnchor, constant: 20)
        ])
    }
    
    private func setNotesLabelValueConstraints() {
        notesLabelValue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesLabelValue.leadingAnchor.constraint(equalTo: notesLabel.leadingAnchor),
            notesLabelValue.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 10),
            notesLabelValue.widthAnchor.constraint(equalToConstant: 290),
            notesLabelValue.bottomAnchor.constraint(equalTo: notesView.bottomAnchor, constant: -32)
        ])
    }
    
    
}
