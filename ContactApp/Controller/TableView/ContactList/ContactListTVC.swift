//
//  ContactListTVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import UIKit

class ContactListTVC: UITableViewController {

    
    private let addButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(Images.addLabel, for: .normal)

        return button
    } ()
    
    private var flag = true
    
    public func getAddButton() -> UIButton {
        return addButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        title = "My Contacts"

        setAddButtonConstrainsts()
        configureAddButton()
        configureTableView()
        ContactsDataSource.populateDummyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if (!flag) {
            flag = true
            self.navigationController?.view.addSubview(addButton)
            setAddButtonConstrainsts()
        }
    }
    
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.insetsContentViewsToSafeArea = true
        tableView.rowHeight = ContactInfoCell.cellHeight
        tableView.separatorStyle = .none
        tableView.register(ContactInfoCell.self, forCellReuseIdentifier: ContactInfoCell.cellIdentifier)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureAddButton() {
        addButton.layer.cornerRadius = 64 / 2
        addButton.clipsToBounds = true
        addButton.layer.masksToBounds = true
        addButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    private func setAddButtonConstrainsts() {
        guard let navigationController = self.navigationController else { return }
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo:navigationController.view.bottomAnchor, constant: -30).isActive = true
        addButton.centerXAnchor.constraint(equalTo: (self.navigationController?.view.centerXAnchor)!).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
    }


}

extension ContactListTVC {
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactsDataSource.getTotalContacts()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoCell.cellIdentifier, for: indexPath) as! ContactInfoCell
        
        let contactInfo = ContactsDataSource.getContactInfo(at: indexPath.row)
        
        cell.set(contactImage: contactInfo.contactImage,
                 contactNameLabel: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                 contactNumberlabel: contactInfo.contactNumber)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if flag {
            addButton.removeFromSuperview()
            flag = false
        }
        
        let individualContactTVC = IndividualContactTVC()
        let contactInfo = ContactsDataSource.getContactInfo(at: indexPath.row)
        
        individualContactTVC.setValues(contactImage: contactInfo.contactImage,
                                       contactName: contactInfo.contactName,
                                       contactNumber: contactInfo.contactNumber,
                                       email: contactInfo.email,
                                       dateOfBirth: contactInfo.dateOfBirth,
                                       notes: contactInfo.notes,
                                       index: indexPath.row)
        
        self.navigationController?.pushViewController(individualContactTVC, animated: true)
    }
    
}

extension ContactListTVC {
    
    @objc private func onButtonTap() {
        
        if flag {
            addButton.removeFromSuperview()
            flag = false
        }
        
        
        let createContactTVC = CreateAndEditContactTVC()
        createContactTVC.configureAsCreateContactView()
        self.navigationController?.pushViewController(createContactTVC, animated: true)
    }
    
}
