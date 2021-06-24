//
//  DetailVC.swift
//  PhoneApp
//
//  Created by Jackie basss on 20.06.2021.
//

import UIKit

class DetailVC: UIViewController {
    // MARK: -Variables
    private let tableView = UITableView()
    
    // #Depends from section
    var contacts: Array<Contact>?
    
    // MARK: -Override
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: -Actions
    
    private func setup() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ContactCell.self, forCellReuseIdentifier: Identifiers.ContactCell.rawValue)
    }

    // #Additional functional for user
    @objc private func copyButtonDidTap(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        if let contact = self.contacts?[sender.tag] {
            if let phoneNumber = contact.phone {
                pasteboard.string = phoneNumber
                timeAlert(title: "Phone number was copied",
                          message: nil, time: 1.2)
            } else {
                if let contactName = contact.name {
                    pasteboard.string = contactName
                    timeAlert(title: "Contact name was copied",
                              message: nil, time: 1.2)
                } else {
                    if let email = contact.email {
                        pasteboard.string = email
                        timeAlert(title: "Email was copied",
                                  message: nil, time: 1.2)
                    } else {
                        timeAlert(title: "Copy action denied", message: "No value to copy",
                                  time: 2)
                    }
                }
            }
        }
        
    }
}


// MARK: -TableView Delegate + DataSource

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.ContactCell.rawValue, for: indexPath) as! ContactCell
        
        cell.selectionStyle = .none
        cell.nameLabel.text = "name: \(contact?.name ?? "--")"
        cell.phoneLabel.text = "phone: \(contact?.phone ?? "--")"
        cell.emailLabel.text = "email: \(contact?.email ?? "--")"
        
        cell.copyButton.tag = indexPath.row
        cell.copyButton.addTarget(self, action: #selector(copyButtonDidTap(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
