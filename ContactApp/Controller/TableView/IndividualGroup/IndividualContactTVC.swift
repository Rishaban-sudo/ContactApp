//
//  IndividualContactTVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit

class IndividualContactTVC: UITableViewController {

    private let _noOfCells: Int = 3
    
    private var recordId: String!
    private var contactImage: UIImage!
    private var contactName: String!
    private var contactNumber: String!
    private var email: String!
    private var dateOfBirth: String!
    private var notes: String!
    
    private var index: Int!
    
    public func setValues(recordId: String,
                          contactImage: UIImage,
                          contactName: String,
                          contactNumber: String,
                          email: String,
                          dateOfBirth: String,
                          notes: String, index: Int) {
        
        self.recordId = recordId
        self.contactImage = contactImage
        self.contactName = contactName
        self.contactNumber = contactNumber
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.notes = notes
        self.index = index
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(onDeleteButtonTap)),
                                              UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onEditButtonTap))]
        
        
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    @objc private func onEditButtonTap() {
        
        let createAndEditContactTVC = CreateAndEditContactTVC()

        createAndEditContactTVC.setValues(recordId: self.recordId,
                                          contactImage: self.contactImage,
                                          firstName: ContactInfo.getFirstName(from: self.contactName),
                                          lastName: ContactInfo.getLastName(from: self.contactName),
                                          email: self.email,
                                          phoneNumber: self.contactNumber,
                                          dateOfBirth: self.dateOfBirth,
                                          notes: self.notes,
                                          index: self.index)

        self.navigationController?.pushViewController(createAndEditContactTVC, animated: true)
    }
    
    @objc private func onDeleteButtonTap() {
        let deleteContactPopVC = DeleteContactPopVC()
        deleteContactPopVC.getDeleteButton().addTarget(self, action: #selector(deleteContact), for: .touchUpInside)
        
        deleteContactPopVC.modalPresentationStyle = .overCurrentContext
        deleteContactPopVC.modalTransitionStyle   = .crossDissolve
        
        self.present(deleteContactPopVC, animated: true)
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
            cell.setCellContext(contactImage: self.contactImage, contactName: ContactInfo.displayContactNameAsFullName(contactName: self.contactName), contactNumber: self.contactNumber)
            cell.isUserInteractionEnabled = true
            cell.getContactImageView().addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            cell.getCallButton().addTarget(self, action: #selector(callNumber), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoContainerCell.cellIdentifier, for: indexPath) as! ContactInfoContainerCell
            cell.setCellContext(mobileNo: self.contactNumber, name: ContactInfo.displayContactNameAsFullName(contactName: self.contactName), email: self.email, dateOfBirth: self.dateOfBirth)
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesContainerCell.cellIdentifier, for: indexPath) as! NotesContainerCell
            cell.setCellContext(notes: self.notes)
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

extension IndividualContactTVC {
    @objc private func deleteContact() {
        ContactsDataSource.deleteContactInfo(at: self.index, recordId: self.recordId)
        dismiss(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension IndividualContactTVC {
    
    @objc private func imageTapped() {
        let imagePreviewPopVC = ImagePreviewPopVC()
        imagePreviewPopVC.setImagePreview(with: contactImage)
        
        imagePreviewPopVC.modalPresentationStyle = .overCurrentContext
        imagePreviewPopVC.modalTransitionStyle   = .crossDissolve
        
        self.present(imagePreviewPopVC, animated: true)
    }
    
}

extension IndividualContactTVC {
    
    @objc private func callNumber() {

        guard let contactNo = self.contactNumber else { return }

        CallAPIWrapper.makePhoneCall(contactNumber: contactNo)

    }
    
}
