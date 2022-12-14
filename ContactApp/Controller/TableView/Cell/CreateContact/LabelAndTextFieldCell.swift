//
//  LabelAndTextFieldCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class LabelAndTextFieldCell: UITableViewCell {

    public static let cellIdentifier = "LabelAndTextFieldCell"
    
    private let label: UILabel = UILabel()
    private let textField: UITextField = UITextField.getUITextFieldInstance(withBorderStyle: .roundedRect)
    
    private let containerView: UIView = UIView()
    
    
    
    public func setCellContext(withLabelText labelTxt: String) {
        label.text = labelTxt
    }
    
    public func getTextField() -> UITextField {
        return textField
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(label)
        containerView.addSubview(textField)
        
        configureLabels()
        
        setLabelConstraints()
        setTextFieldConstraints()
        
        setContainerViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLabels() {
        label.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: true)
        label.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private func setLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    private func setTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 9),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pin(to: contentView)
    }
    
}
