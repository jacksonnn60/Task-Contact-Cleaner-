//
//  ContactSectionCell.swift
//  PhoneApp
//
//  Created by Jackie basss on 20.06.2021.
//

import UIKit



class ContactSectionCell: UITableViewCell {
    // MARK: -Variables
    
    let sectionImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let sectionNameLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    let countLable: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(sectionImageView)
        NSLayoutConstraint.activate([
            sectionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            sectionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sectionImageView.heightAnchor.constraint(equalToConstant: 40),
            sectionImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        contentView.addSubview(sectionNameLabel)
        NSLayoutConstraint.activate([
            sectionNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sectionNameLabel.leadingAnchor.constraint(equalTo: sectionImageView.trailingAnchor, constant: 13),
        ])
        
        contentView.addSubview(countLable)
        NSLayoutConstraint.activate([
            countLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
        ])
    }
    
}
