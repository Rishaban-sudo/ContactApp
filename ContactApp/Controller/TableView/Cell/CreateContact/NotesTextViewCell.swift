//
//  NotesTextViewCell.swift
//  ContactApp
//
//  Created by rishab-13586 on 14/12/22.
//

import UIKit

class NotesTextViewCell: UITableViewCell {

    public static let cellIdentifier = "NotesTextViewCell"
    
    private let notesLabel: UILabel = { let label = UILabel(); label.text = "Notes"; return label } ()
    private let notesTextView: UITextView = UITextView()
    
    private let containerView: UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(notesLabel)
        containerView.addSubview(notesTextView)
        
        configureNotesLabel()
        configureNotesTextView()
        
        setNotesLabelConstraints()
        setNotesTextViewConstraints()
        
        setContainerViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getNotesTextView() -> UITextView {
        return notesTextView
    }
    
    private func configureNotesLabel() {
        notesLabel.setDefaultConfigurations(withFontSize: 15)
        notesLabel.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private func configureNotesTextView() {
        let borderColor: UIColor = UIColor.getUIColorFromHex(rgbValue: 0xececec)
        
        notesTextView.delegate = self
        
        notesTextView.layer.borderWidth = 0.5
        notesTextView.layer.borderColor = borderColor.cgColor
        notesTextView.layer.cornerRadius = 5.0
    }
    
    
    
    private func setNotesLabelConstraints() {
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            notesLabel.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    private func setNotesTextViewConstraints() {
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesTextView.leadingAnchor.constraint(equalTo: notesLabel.leadingAnchor),
            notesTextView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 9),
            notesTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            notesTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            notesTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }
    
    
    private func setContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pin(to: contentView)
    }
    
}

extension NotesTextViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
