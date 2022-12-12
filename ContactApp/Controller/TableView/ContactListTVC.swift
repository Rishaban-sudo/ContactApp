//
//  ContactListTVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import UIKit

class ContactListTVC: UITableViewController {

    private var contactInfoList: [ContactInfo] = []
    private let addButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(Images.addLabel, for: .normal)
//        button.backgroundColor = .systemBlue

        return button
    } ()
    
    private var flag = true
    
    public func getAddButton() -> UIButton {
        return addButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Contacts"
        setAddButtonConstrainsts()
        configureAddButton()
        configureTableView()
        contactInfoList.append(contentsOf: populateDummyData())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (!flag) {
            flag = true
            self.navigationController?.view.addSubview(addButton)
            setAddButtonConstrainsts()
        }
    }
    
    
    private func configureTableView() {
        setTableViewDelegates()
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
    }
    
    private func setAddButtonConstrainsts() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo:(self.navigationController?.view.bottomAnchor)!, constant: -30).isActive = true
        addButton.centerXAnchor.constraint(equalTo: (self.navigationController?.view.centerXAnchor)!).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
    }


}

extension ContactListTVC {
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactInfoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoCell.cellIdentifier, for: indexPath) as! ContactInfoCell
        
        let contactInfo = contactInfoList[indexPath.row]
        
        cell.set(contactImage: contactInfo.contactImage,
                 contactNameLabel: contactInfo.contactName,
                 contactNumberlabel: contactInfo.contactNumber)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if flag {
            addButton.removeFromSuperview()
            flag = false
        }
        
        let individualContactVC = IndividualContactVC()
        let contactInfo = contactInfoList[indexPath.row]
        
        individualContactVC.setValues(contactImage: contactInfo.contactImage, contactName: contactInfo.contactName, contactNumber: contactInfo.contactNumber)
        
        self.navigationController?.pushViewController(individualContactVC, animated: true)
    }
    
}

extension ContactListTVC {
    
    func populateDummyData() -> [ContactInfo] {
        var contactInfoList: [ContactInfo] = []
        for i in 1...30 {
            contactInfoList.append(ContactInfo(contactImage: Images.dummyContactImage,
                                               contactName: "Person \(i)",
                                               contactNumber: "+91 8870961690"))
        }
        return contactInfoList
    }
    
}
