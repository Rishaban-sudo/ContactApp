//
//  ImgContainerCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class ImgContainerCell: UITableViewCell {

    public static let cellIdentifier = "ImgContainerCell"
    
    private let contactImageView: UIImageView = UIImageView()
    private let contactNameLabel: UILabel = UILabel()
    private let contactNumberlabel: UILabel = UILabel()
    private let callButton: UIButton = UIButton()
    private let horizontalSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        return separator
    } ()
    
    private let imgContainerView: UIView = UIView()
    
    public func setCellContext(contactImage: UIImage, contactName: String, contactNumber: String) {
        contactImageView.image = contactImage
        contactNameLabel.text = contactName
        contactNumberlabel.text = contactNumber
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(imgContainerView)
        
        imgContainerView.addSubview(contactImageView)
        imgContainerView.addSubview(contactNameLabel)
        imgContainerView.addSubview(contactNumberlabel)
        imgContainerView.addSubview(callButton)
        imgContainerView.addSubview(horizontalSeparator)
        
        configureContactImageView()
        configureLabels()
        configureCallButton()
        
        setContactImageViewConstraints()
        setContactNameLabelConstraints()
        setContactNumberLabelConstraints()
        setCallButtonConstraints()
        setHorizontalSeparatorConstraints()

        setImgContainerViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            contactImageView.centerXAnchor.constraint(equalTo: imgContainerView.centerXAnchor),
            contactImageView.topAnchor.constraint(equalTo: imgContainerView.topAnchor, constant: 20),
            contactImageView.widthAnchor.constraint(equalToConstant: 100),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor)
        ])
    }
    
    private func setContactNameLabelConstraints() {
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactNameLabel.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 16),
            contactNameLabel.centerXAnchor.constraint(equalTo: contactImageView.centerXAnchor),
//            contactNameLabel.widthAnchor.constraint(equalToConstant: 135)
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
            horizontalSeparator.widthAnchor.constraint(equalTo: imgContainerView.widthAnchor),
            horizontalSeparator.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setImgContainerViewConstraints() {
        imgContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgContainerView.topAnchor.constraint(equalTo: contentView.topAnchor), //, constant: 90
            imgContainerView.heightAnchor.constraint(equalToConstant: 271),
            imgContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
