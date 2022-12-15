//
//  NotesContainerCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class NotesContainerCell: UITableViewCell {

    public static let cellIdentifier = "NotesContainerCell"
    
    private let notesLabel: UILabel = UILabel()
    private let notesLabelValue: UILabel = UILabel()
    
    private let notesView: UIView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(notesView)

        notesView.addSubview(notesLabel)
        notesView.addSubview(notesLabelValue)
        
        configureNotesView()
        configureLabels()

        setNotesViewConstraints()

        setNotesLabelConstraints()
        setNotesLabelValueConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setCellContext(notes: String) {
        notesLabelValue.text = notes
    }
    
    
    private func configureNotesView() {
        notesView.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0xf3f9ff, alpha: 1)
        notesView.layer.cornerRadius = 7
    }
    
    private func configureLabels() {
        notesLabel.setDefaultConfigurations(withFontSize: 16, adjustsFontSizeToFitWidth: true)
        notesLabel.font =  UIFont.boldSystemFont(ofSize: 16)
        notesLabel.text = "Notes"
        
        notesLabelValue.setDefaultConfigurations(withFontSize: 15, adjustsFontSizeToFitWidth: false)
    }
    
    private func setNotesViewConstraints() {
        notesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            notesView.widthAnchor.constraint(equalToConstant: 330),
            notesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            notesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            notesView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            notesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            notesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
            notesLabelValue.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: -20),
            notesLabelValue.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 10),
//            notesLabelValue.widthAnchor.constraint(equalToConstant: 290),
            notesLabelValue.bottomAnchor.constraint(equalTo: notesView.bottomAnchor, constant: -32)
        ])
    }
    
}
