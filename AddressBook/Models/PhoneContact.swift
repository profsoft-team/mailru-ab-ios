//
//  PhoneContact.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import ContactsUI

protocol BaseContact {
    var name: String? { get }
    var avatarImage: UIImage? { get }
    var mainPhoneNumber: String? { get }
}

struct PhoneContact {

    let name: String?
    let avatarImage: UIImage?
    var phoneNumbers: [String] = [String]()
    var emails: [String] = [String]()
    
    var mainPhoneNumber: String? {
        phoneNumbers.first
    }

    init(contact: CNContact) {
        name = contact.givenName + " " + contact.familyName
        let _avatarData = contact.thumbnailImageData
        
        if let avatarData = _avatarData {
            avatarImage = UIImage(data: avatarData)
        } else {
            avatarImage = nil
        }
        
        for phone in contact.phoneNumbers {
            phoneNumbers.append(phone.value.stringValue)
        }
        for mail in contact.emailAddresses {
            emails.append(mail.value as String)
        }
    }
}

extension PhoneContact: BaseContact {}
