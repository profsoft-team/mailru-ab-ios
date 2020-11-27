//
//  ContactDetailsScreenBuilder.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation

struct ContactDetailsScreenBuilder {
    
    static func build(with model: PhoneContact) -> [ContactDetailsDataSource.SectionType] {
        
        var items = [ContactDetailsTableViewItem]()
        
        let generalItem = ContactDetailsTableViewItem.generalCell(model)
        items.append(generalItem)
        
        model.phoneNumbers
            .forEach {
                let phoneItem = ContactDetailsTableViewItem.phoneNumberCell($0)
                items.append(phoneItem)
            }
        
        let sections = [ContactDetailsDataSource.SectionType(model: "ContactDetails",
                                                             items: items)]
        return sections
    }
}
