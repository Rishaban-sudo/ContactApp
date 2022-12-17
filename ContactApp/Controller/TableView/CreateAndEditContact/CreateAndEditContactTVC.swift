//
//  CreateContactTVC.swift
//  ContactApp
//
//  Created by rishab-13586 on 13/12/22.
//

import UIKit



class CreateAndEditContactTVC: UITableViewController {

    private let _noOfCells: Int = 7
    
    private let datePicker = UIDatePicker()
    private var dobTextField: UITextField?
    
    
    private var contactImage: UIImage?
    private var firstName: String!
    private var lastName: String!
    private var email: String!
    private var phoneNumber: String!
    private var dateOfBirth: String!
    private var notes: String!
    
    
    private var index: Int!
    private var isEditView: Bool = false
    
    
    public func setValues(contactImage: UIImage,
                          firstName: String,
                          lastName: String,
                          email: String,
                          phoneNumber: String,
                          dateOfBirth: String,
                          notes: String,
                          index: Int,
                          isEditView: Bool = true)
    {
        self.contactImage = contactImage
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.notes = notes
        self.index = index
        self.isEditView = isEditView
    }
    
    public func configureAsCreateContactView() {
        self.isEditView = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideUserInterfaceStyle = .light
        hideKeyboardWhenTappedAround()
        

        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveButtonTapped))
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isEditView {
            title = "Edit"
        }
        else {
            title = "Create Contact"
        }
    }
    
    private func configureTableView() {
        setTableViewDelegates()
        tableView.insetsContentViewsToSafeArea = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(CreateContactImgCell.self, forCellReuseIdentifier: CreateContactImgCell.cellIdentifier)
        tableView.register(LabelAndTextFieldCell.self, forCellReuseIdentifier: LabelAndTextFieldCell.cellIdentifier)
        tableView.register(NotesTextViewCell.self, forCellReuseIdentifier: NotesTextViewCell.cellIdentifier)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension CreateAndEditContactTVC {
    
    @objc func onSaveButtonTapped() {
        
        if isEditView {
            
            let contactInfo =  ContactInfo(contactImage: self.contactImage ?? Images.dummyContactImage,
                        contactName: ContactInfo.concatenateFirstNameAndLastNameToPersist(firstName: self.firstName, lastName: self.lastName),
                        contactNumber: self.phoneNumber,
                        email: self.email,
                        dateOfBirth: self.dateOfBirth,
                        notes: self.notes)
            
            ContactsDataSource.editContactInfo(at: self.index, contact: contactInfo)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        else {
            
            if self.contactImage != nil &&
                self.firstName != nil &&
                self.lastName != nil &&
                self.phoneNumber != nil &&
                self.email != nil &&
                self.dateOfBirth != nil &&
                self.notes != nil
            {
                let contactInfo = ContactInfo(contactImage: self.contactImage ?? Images.dummyContactImage,
                                              contactName: ContactInfo.concatenateFirstNameAndLastNameToPersist(firstName: self.firstName, lastName: self.lastName),
                                              contactNumber: self.phoneNumber,
                                              email: self.email,
                                              dateOfBirth: self.dateOfBirth,
                                              notes: self.notes)
                
                ContactsDataSource.addContactInfo(contact: contactInfo)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
    }
    
}


extension CreateAndEditContactTVC {
    
    private func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onDoneButtonTapped))
        toolBar.setItems([doneButton],
                         animated: true)
        
        return toolBar
    }
    
    private func createDatePicker(forTextFieldIn cell: LabelAndTextFieldCell) {
        dobTextField = cell.getTextField()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
        } else {
            // Fallback on earlier versions
        }
        
        dobTextField?.inputView = datePicker
        dobTextField?.inputAccessoryView = createToolBar()
    }
    
    @objc private func onDoneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
        
        dobTextField?.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}

extension CreateAndEditContactTVC {
    
    private func setNumericKeyPadForInput(forTextFieldIn cell: LabelAndTextFieldCell) {
        cell.getTextField().keyboardType = UIKeyboardType.phonePad
    }
    
    private func setEmailKeyBoardForInput(forTextFieldIn cell: LabelAndTextFieldCell) {
        cell.getTextField().keyboardType = UIKeyboardType.emailAddress
    }
}

extension CreateAndEditContactTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _noOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateContactImgCell.cellIdentifier, for: indexPath) as! CreateContactImgCell
            cell.setContactImage(contactImage: self.contactImage ?? Images.dummyContactImage)
            cell.getContactImgButton().addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//            cell.getTextField().becomeFirstResponder()
            cell.setCellContext(withLabelText: "First Name")
            if (isEditView) {
                cell.getTextField().text = firstName
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            cell.setCellContext(withLabelText: "Last Name")
            if (isEditView) {
                cell.getTextField().text = lastName
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            cell.setCellContext(withLabelText: "Email")
            if (isEditView) {
                cell.getTextField().text = email
            }
            setEmailKeyBoardForInput(forTextFieldIn: cell)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            cell.setCellContext(withLabelText: "Phone Number")
            if (isEditView) {
                cell.getTextField().text = phoneNumber
            }
            setNumericKeyPadForInput(forTextFieldIn: cell)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
            cell.setCellContext(withLabelText: "Date of Birth")
            if (isEditView) {
                cell.getTextField().text = dateOfBirth
            }
            createDatePicker(forTextFieldIn: cell)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesTextViewCell.cellIdentifier, for: indexPath) as! NotesTextViewCell
            cell.getNotesTextView().tag = indexPath.row
            cell.getNotesTextView().delegate = self
            if (isEditView) {
                cell.getNotesTextView().text = notes
            }
            return cell
        default:
            fatalError("unexpected index !!")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension CreateAndEditContactTVC {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let index = IndexPath(row: textField.tag, section: 0)
        guard let cell = tableView.cellForRow(at: index) as? LabelAndTextFieldCell else {
            return
        }
        
        if index.row == 1 {
            self.firstName = cell.getTextField().text
        }
        else if index.row == 2 {
            self.lastName = cell.getTextField().text
        }
        else if index.row == 3 {
            self.email = cell.getTextField().text
        }
        else if index.row == 4 {
            self.phoneNumber = cell.getTextField().text
        }
        else if index.row == 5 {
            self.dateOfBirth = cell.getTextField().text
        }
        
    }
    
}

extension CreateAndEditContactTVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let index = IndexPath(row: textView.tag, section: 0)
        guard let cell = tableView.cellForRow(at: index) as? NotesTextViewCell else {
            return
        }
        
        // just for safety check
        if index.row == 6 {
            self.notes = cell.getNotesTextView().text
        }
    }
}

extension CreateAndEditContactTVC {
    
    @objc private func uploadImage() {
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.sourceType = .photoLibrary
        uiImagePickerController.delegate = self
        uiImagePickerController.allowsEditing = true
        self.present(uiImagePickerController, animated: true)
    }

}


extension CreateAndEditContactTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else {
            return
        }
        
        self.contactImage = image
        let createContactImgCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CreateContactImgCell
        createContactImgCell.getContactImgButton().setBackgroundImage(image, for: .normal)
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
