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
    private let switchView: UISwitch = UISwitch()
    
    private var flag = true
    private var switchFlag = false
    
    public func getAddButton() -> UIButton {
        return addButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        switchView.addTarget(self, action: #selector(didSwitchStateChange), for: .valueChanged)
        let barBtn = UIBarButtonItem(customView: switchView)
        navigationItem.leftBarButtonItem = barBtn
        
        title = "My Contacts"

        setAddButtonConstrainsts()
        configureAddButton()
        configureTableView()
        
        ContactsDataSource.contactsDataViewDelegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(ContactInfoCell.self, forCellReuseIdentifier: ContactInfoCell.cellIdentifier)
        tableView.register(LargeTileContactinfoCell.self, forCellReuseIdentifier: LargeTileContactinfoCell.cellIdentifier)
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
        addButton.centerXAnchor.constraint(equalTo: navigationController.view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
    }


}

extension ContactListTVC {
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactsDataSource.getTotalContacts()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !switchFlag {
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoCell.cellIdentifier, for: indexPath) as! ContactInfoCell
            let contactInfo = ContactsDataSource.getContactInfo(at: indexPath.row)

            cell.set(contactImage: contactInfo.contactImage,
                     contactNameLabel: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                     contactNumberlabel: contactInfo.contactNumber)



            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LargeTileContactinfoCell.cellIdentifier, for: indexPath) as! LargeTileContactinfoCell
            let contactInfo = ContactsDataSource.getContactInfo(at: indexPath.row)

            cell.setCellContext(contactImage: contactInfo.contactImage,
                                contactName: ContactInfo.displayContactNameAsFullName(contactName: contactInfo.contactName),
                                contactNumber: contactInfo.contactNumber)
            

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if flag {
            addButton.removeFromSuperview()
            flag = false
        }
        
        let individualContactTVC = IndividualContactTVC()
        let contactInfo = ContactsDataSource.getContactInfo(at: indexPath.row)
        
        individualContactTVC.setValues(recordId: contactInfo.recordId , // as of since we will not be getting recordId for newly added record
                                       contactImage: contactInfo.contactImage,
                                       contactName: contactInfo.contactName,
                                       contactNumber: contactInfo.contactNumber,
                                       email: contactInfo.email,
                                       dateOfBirth: contactInfo.dateOfBirth,
                                       notes: contactInfo.notes,
                                       index: indexPath.row)
        
        self.navigationController?.pushViewController(individualContactTVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: "Delete",
                                                handler: { (action, indexpath) in
            let contactInfo = ContactsDataSource.getContactInfo(at: indexpath.row)
            ContactsDataSource.deleteContactInfo(at: indexpath.row, recordId: contactInfo.recordId)
            tableView.deleteRows(at: [indexpath], with: .automatic)
        })
        
        return [deleteAction]
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
    
    @objc private func didSwitchStateChange(_ sender: UISwitch) {
        if sender.isOn {
            switchFlag = true
        }
        else {
            switchFlag = false
        }
        tableView.reloadData()
    }
    
}

extension ContactListTVC: ContactsDataViewDelegate {
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
    
}
