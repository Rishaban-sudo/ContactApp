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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        title = "Create Contact"
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
        
        configureTableView()
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
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.setCellContext(withLabelText: "First Name")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.setCellContext(withLabelText: "Last Name")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.setCellContext(withLabelText: "Email")
            setEmailKeyBoardForInput(forTextFieldIn: cell)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.setCellContext(withLabelText: "Phone Number")
            setNumericKeyPadForInput(forTextFieldIn: cell)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelAndTextFieldCell.cellIdentifier, for: indexPath) as! LabelAndTextFieldCell
            cell.setCellContext(withLabelText: "Date of Birth")
            createDatePicker(forTextFieldIn: cell)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesTextViewCell.cellIdentifier, for: indexPath) as! NotesTextViewCell
            return cell
        default:
            fatalError("unexpected index !!")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
