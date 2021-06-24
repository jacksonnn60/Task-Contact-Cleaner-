//
//  ViewController.swift
//  PhoneApp
//
//  Created by Jackie basss on 20.06.2021.
//

import UIKit
import ContactsUI

//- все контакты;
//- дублирующиеся имена;
//- дублирующиеся номера;
//- нет имени;
//- нет номера;
//- нет емейла.

class ContactCleanerVC: UIViewController {
    // MARK: -Variables
    private let tableView = UITableView()
    private let phoneManager = ContactManager.shared
    
    // MARK: -Override
    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    // MARK: -Actions
    private func configure() {
        self.title = "Contact cleaner"
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.tableFooterView = UIView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ContactSectionCell.self, forCellReuseIdentifier: Identifiers.ContactSectionCell.rawValue)
    }

}

// MARK: -TableView Delegate + DataSource

extension ContactCleanerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ContactSectionCell.rawValue, for: indexPath) as! ContactSectionCell
        
        setupCell(cell, indexPath: indexPath)
            
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets(top: 0, left: 67, bottom: 0, right: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailVC()
        
        switch indexPath.row {
            case 0:
                vc.title = "All contacts"
                vc.contacts = phoneManager.contacts
                break
            case 1:
                vc.title = "Duplicate names"
                vc.contacts = phoneManager.contactsWithDuplicateNames
                break
            case 2:
                vc.title = "Duplicate numbers"
                vc.contacts = phoneManager.contactsWithDuplicatePhones
                break
            case 3:
                vc.title = "No names"
                vc.contacts = phoneManager.contactsWihoutName
                break
            case 4:
                vc.title = "No numbers"
                vc.contacts = phoneManager.contactsWithoutNumbers
                break
            case 5:
                vc.title = "No emails"
                vc.contacts = phoneManager.contactsWithoutEmail
                break                
            default:
                break
        }
        self.navigationController?.pushViewController(vc, animated: true)                
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func setupCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? ContactSectionCell else { return }
        cell.countLable.text = "0"

        switch indexPath.row {
            case 0:
                cell.sectionImageView.image = UIImage(named: "contacts")
                cell.sectionNameLabel.text = "All contacts"
                
                DispatchQueue.main.async {
                    cell.countLable.text = "\(self.phoneManager.contacts.count)"
                }
                
                break
            case 1:
                cell.sectionImageView.image = UIImage(named: "duplicateNames")
                cell.sectionNameLabel.text = "Duplicate names"
                
                DispatchQueue.main.async {
                    cell.countLable.text = "\(self.phoneManager.contactsWithDuplicateNames.count)"
                }
                
                break
            case 2:
                cell.sectionImageView.image = UIImage(named: "duplicateNumbers")
                cell.sectionNameLabel.text = "Duplicate numbers"
                
                DispatchQueue.main.async {
                    cell.countLable.text = "\(self.phoneManager.contactsWithDuplicatePhones.count)"
                }
                
                break
            case 3:
                cell.sectionImageView.image = UIImage(named: "contacts")
                cell.sectionNameLabel.text = "No names"
                
                DispatchQueue.main.async {
                    cell.countLable.text = "\(self.phoneManager.contactsWihoutName.count)"
                }
                
                break
            case 4:
                cell.sectionImageView.image = UIImage(named: "no_call")
                cell.sectionNameLabel.text = "No numbers"
                
                DispatchQueue.main.async {
                    cell.countLable.text = "\(self.phoneManager.contactsWithoutNumbers.count)"
                }
                
                break
            case 5:
                cell.sectionImageView.image = UIImage(named: "mail")
                cell.sectionNameLabel.text = "No emails"
                
                DispatchQueue.main.async {
                    cell.countLable.text = "\(self.phoneManager.contactsWithoutEmail.count)"
                }
                
                break
            default:
                break
        }
    }
    
}
