//
//  LargeTiltContactinfoCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 16/12/22.
//

import UIKit

class LargeTileContactinfoCell: UITableViewCell {

    public static let cellIdentifier = "LargeTileContactinfoCell"
    
    private let contactImageView: UIImageView = UIImageView()
    private let contactNameLabel: UILabel = UILabel()
    private let contactNumberlabel: UILabel = UILabel()
    private let callButton: UIButton = UIButton()
    
    private let containerView: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.addSubview(containerView)
        
        containerView.addSubview(contactImageView)
        containerView.addSubview(contactNameLabel)
        containerView.addSubview(contactNumberlabel)
        containerView.addSubview(callButton)
        
        configureContactImageView()
        configureLabels()
        configureCallButton()
        
        setContainerViewConstraints()
        
        setContactImageViewConstraints()
        setContactNameLabelConstraints()
        setContactNumberLabelConstraints()
        setCallButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setCellModel(contactInfoCellModel: ContactInfoCellModel) {
        self.contactImageView.image  = contactInfoCellModel.contactImage
        self.contactNameLabel.text   = contactInfoCellModel.contactNameLabel
        self.contactNumberlabel.text = contactInfoCellModel.contactNumberlabel
    }
    
    @available(*, deprecated, message: "use setCellModel method")
    public func setCellContext(contactImage: UIImage, contactName: String, contactNumber: String) {
        contactImageView.image = contactImage
        contactNameLabel.text = contactName
        contactNumberlabel.text = contactNumber
    }
    
    
    private func configureContactImageView() {
        contactImageView.layer.cornerRadius = 5
        contactImageView.clipsToBounds = true
        contactImageView.contentMode = .scaleAspectFill
    }
    
    
    private func configureLabels() {
        contactNameLabel.setDefaultConfigurations(withFontSize: 18, adjustsFontSizeToFitWidth: true)
        contactNameLabel.textAlignment = .left
        
        contactNumberlabel.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        contactNumberlabel.textAlignment = .left
    }
    
    private func configureCallButton() {
        callButton.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x00AB00)
        callButton.setTitle("Call", for: .normal)
        callButton.setTitleColor(.white, for: .normal)
        callButton.setTitleColor(.lightGray, for: .highlighted)
        callButton.layer.cornerRadius = 5
        callButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
    }
    
    
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pin(to: contentView)
    }
    
    private func setContactImageViewConstraints() {
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            contactImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            contactImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            contactImageView.heightAnchor.constraint(equalToConstant: 174)
        ])
    }
    
    private func setContactNameLabelConstraints() {
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactNameLabel.leadingAnchor.constraint(equalTo: contactImageView.leadingAnchor),
            contactNameLabel.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 15),
            contactNameLabel.trailingAnchor.constraint(equalTo: callButton.leadingAnchor, constant: -35)
        ])
    }
    
    private func setContactNumberLabelConstraints() {
        contactNumberlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactNumberlabel.leadingAnchor.constraint(equalTo: contactImageView.leadingAnchor),
            contactNumberlabel.topAnchor.constraint(equalTo: contactNameLabel.bottomAnchor, constant: 5),
            contactNumberlabel.trailingAnchor.constraint(equalTo: contactNameLabel.trailingAnchor),
            contactNumberlabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setCallButtonConstraints() {
        callButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callButton.heightAnchor.constraint(equalToConstant: 40),
            callButton.widthAnchor.constraint(equalToConstant: 129),
            callButton.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 18),
            callButton.trailingAnchor.constraint(equalTo: contactImageView.trailingAnchor),
            callButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
    }
    
    
}

extension LargeTileContactinfoCell {

    @objc private func callNumber() {

        guard let contactNo = self.contactNumberlabel.text else { return }

        CallAPIWrapper.makePhoneCall(contactNumber: contactNo)

    }

}
