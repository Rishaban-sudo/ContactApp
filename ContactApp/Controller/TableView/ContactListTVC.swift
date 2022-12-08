//
//  ContactListTVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import UIKit

class ContactListTVC: UITableViewController {

    private var contactInfoList: [ContactInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Contacts"
        configureTableView()
        contactInfoList.append(contentsOf: populateDummyData())
    }
    
    func configureTableView() {
        setTableViewDelegates()
        tableView.rowHeight = ContactInfoCell.cellHeight
        tableView.separatorStyle = .none
        tableView.register(ContactInfoCell.self, forCellReuseIdentifier: ContactInfoCell.cellIdentifier)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }


    /*
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    */

}

extension ContactListTVC {
    
    // MARK: - Table view data source

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
