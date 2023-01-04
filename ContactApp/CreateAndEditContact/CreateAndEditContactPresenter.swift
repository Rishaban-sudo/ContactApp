//
//  CreateAndEditContactPresenter.swift
//  ContactApp
//
//  Created by rishab-13586 on 02/01/23.
//

import Foundation
import UIKit

class CreateAndEditContactPresenter: NSObject,ViewToPresenterCreateAndEditContactProtocol {
    
    weak var view: PresenterToViewCreateAndEditContactProtocol?
    var interactor: PresenterToInteractorCreateAndEditContactProtocol?
    var router: PresenterToRouterCreateAndEditContactProtocol?
    
    var contactDetail: ContactDetail!
    
    private var isEditView: Bool = false
    private let _noOfCells: Int = 7
    
    private let datePicker = UIDatePicker()
    private var dobTextField: UITextField?
    
    
    func getContactInfoModel(from contactDetail: ContactDetail) -> ContactInfo {
        
        if isEditView {
            let contactInfo = ContactInfo(recordId: contactDetail.recordId,
                                          contactImage: contactDetail.contactImage,
                                          contactName: ContactInfo.concatenateFirstNameAndLastNameToPersist(firstName: contactDetail.firstName,
                                                                                                            lastName: contactDetail.lastName),
                                          contactNumber: contactDetail.phoneNumber,
                                          email: contactDetail.email,
                                          dateOfBirth: contactDetail.dateOfBirth,
                                          notes: contactDetail.notes)
            
            return contactInfo
        }
        else {
            let contactInfo = ContactInfo(recordId: nil,
                                          contactImage: contactDetail.contactImage,
                                          contactName: ContactInfo.concatenateFirstNameAndLastNameToPersist(firstName: contactDetail.firstName,
                                                                                                            lastName: contactDetail.lastName),
                                          contactNumber: contactDetail.phoneNumber,
                                          email: contactDetail.email,
                                          dateOfBirth: contactDetail.dateOfBirth,
                                          notes: contactDetail.notes)
            
            return contactInfo
        }
        
    }
    
    
    func viewDidLoad() {
        // in create contact case we don't need to fetch data from interactor
        if isEditView {
            guard let contactInfo = interactor?.getIndividualContactInfo() else { return }
            contactDetail = ContactDetail(recordId: contactInfo.recordId,
                                          contactImage: contactInfo.contactImage,
                                          firstName: ContactInfo.getFirstName(from: contactInfo.contactName),
                                          lastName: ContactInfo.getLastName(from: contactInfo.contactName),
                                          email: contactInfo.email,
                                          phoneNumber: contactInfo.contactNumber,
                                          dateOfBirth: contactInfo.dateOfBirth,
                                          notes: contactInfo.notes)
        }
        else {
            contactDetail = ContactDetail(contactImage: Images.dummyContactImage)
        }
    }
    
    func viewWillAppear() {
        if isEditView {
            view?.setViewTitle(title: "Edit")
        }
        else {
            view?.setViewTitle(title: "Create Contact")
        }
    }
    
    func setIsEditView(to state: Bool) {
        isEditView = state
    }
    
    func numberOfRowsInSection() -> Int {
        return _noOfCells
    }
    
    func setCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateContactImgCell.cellIdentifier, for: indexPath) as! CreateContactImgCell
            
            if isEditView {
                cell.setContactImage(contactImage: contactDetail.contactImage)
            }
            else { // for create contact we will show the default image
                cell.setContactImage(contactImage: Images.dummyContactImage)
            }
            
            cell.getContactImgButton().addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            cell.setCellContext(withLabelText: "First Name")
            
            if (isEditView) {
                cell.getTextField().text = contactDetail.firstName
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            cell.setCellContext(withLabelText: "Last Name")
            
            if (isEditView) {
                cell.getTextField().text = contactDetail.lastName
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            cell.setCellContext(withLabelText: "Email")
            
            if (isEditView) {
                cell.getTextField().text = contactDetail.email
            }
            
            setEmailKeyBoardForInput(forTextFieldIn: cell)
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            
            cell.setCellContext(withLabelText: "Phone Number")
            
            if (isEditView) {
                cell.getTextField().text = contactDetail.phoneNumber
            }
            
            setNumericKeyPadForInput(forTextFieldIn: cell)
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.getTextField().tag = indexPath.row
            cell.getTextField().addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
            
            cell.setCellContext(withLabelText: "Date of Birth")
            if (isEditView) {
                cell.getTextField().text = contactDetail.dateOfBirth
            }
            
            createDatePicker(forTextFieldIn: cell)
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesTextViewCell.cellIdentifier, for: indexPath) as! NotesTextViewCell
            cell.getNotesTextView().tag = indexPath.row
            cell.getNotesTextView().delegate = self
            
            if (isEditView) {
                cell.getNotesTextView().text = contactDetail.notes
            }
            
            return cell
        default:
            fatalError("unexpected index !!")
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath, tableView: UITableView) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    private func validate(contactDetail: ContactDetail) -> Bool {
        if (contactDetail.firstName != nil && contactDetail.firstName != "") &&
            (contactDetail.lastName != nil && contactDetail.lastName != "") &&
            (contactDetail.email != nil && contactDetail.email != "") &&
            (contactDetail.phoneNumber != nil && contactDetail.phoneNumber != "") &&
            (contactDetail.dateOfBirth != nil && contactDetail.dateOfBirth != "") &&
            (contactDetail.notes != nil && contactDetail.notes != "")
        {
            return true
        }
        else {
            return false
        }
    }
    
    func saveButtonTapped() {
        if isEditView {
            
            if (validate(contactDetail: self.contactDetail))
            {
                view?.showLoadingScreen()
                interactor?.editContact(contact: getContactInfoModel(from: self.contactDetail))
            }
            else {
                view?.showAlert(title: "Insufficient Data", message: "Please do fill all the fields")
            }
            
        }
        else {
            
            if (validate(contactDetail: self.contactDetail))
            {
                view?.showLoadingScreen()
                interactor?.addContact(contact: getContactInfoModel(from: self.contactDetail))
            }
            else {
                view?.showAlert(title: "Insufficient Data", message: "Please do fill all the fields")
            }
            
        }
    }
    
    func returnToContactListScreen(navController: UINavigationController) {
        router?.popToHomeScreen(navController: navController)
    }
    
}

extension CreateAndEditContactPresenter {
    
    @objc private func uploadImage() {
        let uiImagePickerController = UIImagePickerController()
        uiImagePickerController.sourceType = .photoLibrary
        uiImagePickerController.delegate = self
        uiImagePickerController.allowsEditing = true
        
        view?.present(viewControllerToPresent: uiImagePickerController, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let index = IndexPath(row: textField.tag, section: 0)
        guard let cell = view?.cellForRow(at: index) as? LabelAndTextFieldCell else {
            return
        }
        
        if index.row == 1 {
            self.contactDetail.firstName = cell.getTextField().text
        }
        else if index.row == 2 {
            self.contactDetail.lastName = cell.getTextField().text
        }
        else if index.row == 3 {
            self.contactDetail.email = cell.getTextField().text
        }
        else if index.row == 4 {
            self.contactDetail.phoneNumber = cell.getTextField().text
        }
        else if index.row == 5 {
            self.contactDetail.dateOfBirth = cell.getTextField().text
        }
        
    }
    
    private func setNumericKeyPadForInput(forTextFieldIn cell: LabelAndTextFieldCell) {
        cell.getTextField().keyboardType = UIKeyboardType.phonePad
    }
    
    private func setEmailKeyBoardForInput(forTextFieldIn cell: LabelAndTextFieldCell) {
        cell.getTextField().keyboardType = UIKeyboardType.emailAddress
    }
    
    @objc private func onDoneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        dobTextField?.text = dateFormatter.string(from: datePicker.date)
        view?.endEditing(true)
    }
    
    private func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTapped))
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
    
    
}

extension CreateAndEditContactPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else {
            return
        }
        
        self.contactDetail.contactImage = image
        let createContactImgCell = view?.cellForRow(at: IndexPath(row: 0, section: 0)) as! CreateContactImgCell
        createContactImgCell.getContactImgButton().setBackgroundImage(image, for: .normal)
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}


extension CreateAndEditContactPresenter: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let index = IndexPath(row: textView.tag, section: 0)
        guard let cell = view?.cellForRow(at: index) as? NotesTextViewCell else {
            return
        }
        
        // just for safety check
        if index.row == 6 {
            self.contactDetail.notes = cell.getNotesTextView().text
        }
    }
    
}


extension CreateAndEditContactPresenter: InteractorToPresenterCreateAndEditContactProtocol {
    
    func onAddContactSuccess(message: String) {
        view?.dismissLoadingScreen()
        view?.showAlertWith(title: "Contact Added Successfully", message: message)
    }
    
    func onAddConatctFailure(message: String) {
        view?.dismissLoadingScreen()
        view?.showAlert(title: "Error!!", message: message)
    }
    
    func onEditContactSuccess(message: String) {
        view?.dismissLoadingScreen()
        view?.showAlertWith(title: "Contact Updated Successfully", message: message)
    }
    
    func onEditContactFailure(message: String) {
        view?.dismissLoadingScreen()
        view?.showAlert(title: "Failed to Edit!!", message: message)
    }
    
}
