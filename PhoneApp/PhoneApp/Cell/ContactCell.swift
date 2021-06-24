//
//  ContactCell.swift
//  PhoneApp
//
//  Created by Jackie basss on 20.06.2021.
//

import UIKit

class ContactCell: UITableViewCell {
    // MARK: -Variables
    
    let nameLabel: UILabel = {
        let obj = UILabel()
        obj.font = UIFont.boldSystemFont(ofSize: 19)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let phoneLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let emailLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .darkGray
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let copyButton: UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(systemName: "doc.on.doc.fill"), for: .normal)
        obj.translatesAutoresizingMaskIntoConstraints =  false
        return obj
    }()
    
    // MARK: -Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Actions
    
    private func setup() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
        ])
        
        contentView.addSubview(phoneLabel)
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
        ])
        
        contentView.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 12),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
        ])
        
        contentView.addSubview(copyButton)
        NSLayoutConstraint.activate([
            copyButton.bottomAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            copyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
}
