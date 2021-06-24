//
//  PhoneManager.swift
//  PhoneApp
//
//  Created by Jackie basss on 20.06.2021.
//

import Foundation
import ContactsUI

final class ContactManager {
    
    // MARK: -Variables
    static let shared = ContactManager()
    private let contactStore = CNContactStore()
    
    var contacts: Array<Contact> = []
    var contactsWihoutName: Array<Contact> = []
    var contactsWithoutEmail: Array<Contact> = []
    var contactsWithoutNumbers: Array<Contact> = []
    var contactsWithDuplicateNames: Array<Contact> = []
    var contactsWithDuplicatePhones: Array<Contact> = []

    
    private let keys =
        [ CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
          CNContactPhoneNumbersKey, CNContactEmailAddressesKey ] as [Any]
    
    private lazy var request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])


    // MARK: -Init
    private init() { fecthContacts(); getDuplicates() }
    
    // MARK: -Actions
    
    private func getDuplicates() {
        var i = 0
        while( i != contacts.count ) {
            let firstContact = contacts[i]
            
            var j = 0
            while ( j != contacts.count ) {
                let currentContact = contacts[j]
                
                // Protect from situation of comparing between two same index.
                if i != j {
                    // Get name duplicates
                    if firstContact.name != nil, firstContact.name == currentContact.name {
                        self.contactsWithDuplicateNames.append(currentContact)
                    }
                    
                    // Get phone duplicates
                    if firstContact.phone != nil, firstContact.phone == currentContact.phone {
                        self.contactsWithDuplicatePhones.append(currentContact)
                    }
                }
                j += 1
            }
            i += 1
        }
    }

    private func fecthContacts() {
        do {
            try contactStore.enumerateContacts(with: request) { [weak self]
                (contact, stop) in
                
                if let customContact = self?.mutateToCustomModel(contact) {
                    self?.contacts.append(customContact)
                    self?.checkForSimpleOptions(contact: customContact)
                }
            }
        } catch {
            print("Error fetching contacts")
        }
    }
    
    private func mutateToCustomModel(_ contact: CNContact) -> Contact {
        var newContact = Contact(name: nil, phone: nil, email: nil)
        
        let firstName = "\(contact.givenName)"
        let lastName = "\(contact.familyName)"

        let phone = contact.phoneNumbers.first?.value.stringValue
        let email = contact.emailAddresses.first?.value
        
        if firstName != "" && lastName != "" {
            newContact.name = "\(firstName) \(lastName)"
        }
        
        if phone != nil {
            newContact.phone = phone
        }
        
        if email != nil {
            newContact.email = email as String?
        }
        
        return newContact
    }
    
    private func checkForSimpleOptions(contact: Contact) {
        // check for number existing
        if contact.phone == nil {
            self.contactsWithoutNumbers.append(contact)
        }
        
        // check for email
        if contact.email == nil {
            self.contactsWithoutEmail.append(contact)
        }
        
        // check for name
        if contact.name == nil {
            self.contactsWihoutName.append(contact)
        }
    }
}



