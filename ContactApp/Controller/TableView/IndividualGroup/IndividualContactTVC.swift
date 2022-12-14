//
//  IndividualContactTVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class IndividualContactTVC: UITableViewController {

    private let _noOfCells: Int = 3
    
    private var contactImage: UIImage!
    private var contactName: String!
    private var contactNumber: String!
    private var email: String!
    private var dateOfBirth: String!
    private var notes: String!
    
    public func setValues(contactImage: UIImage,
                          contactName: String,
                          contactNumber: String,
                          email: String,
                          dateOfBirth: String,
                          notes: String) {
        
        self.contactImage = contactImage
        self.contactName = contactName
        self.contactNumber = contactNumber
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.notes = notes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Delete", style: .plain, target: self, action: nil),
                                              UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)]
        
        configureTableView()
    }

    private func configureTableView() {
        setTableViewDelegates()
        tableView.insetsContentViewsToSafeArea = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(ImgContainerCell.self, forCellReuseIdentifier: ImgContainerCell.cellIdentifier)
        tableView.register(ContactInfoContainerCell.self, forCellReuseIdentifier: ContactInfoContainerCell.cellIdentifier)
        tableView.register(NotesContainerCell.self, forCellReuseIdentifier: NotesContainerCell.cellIdentifier)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension IndividualContactTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _noOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImgContainerCell.cellIdentifier, for: indexPath) as! ImgContainerCell
            cell.setCellContext(contactImage: contactImage, contactName: contactName, contactNumber: contactNumber)
            cell.isUserInteractionEnabled = true
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoContainerCell.cellIdentifier, for: indexPath) as! ContactInfoContainerCell
            cell.setCellContext(mobileNo: contactNumber, name: contactName, email: email, dateOfBirth: dateOfBirth)
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesContainerCell.cellIdentifier, for: indexPath) as! NotesContainerCell
            cell.setCellContext(notes: notes)
            cell.isUserInteractionEnabled = false
            return cell
        default:
            fatalError("unbounded index !!")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
