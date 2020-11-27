//
//  AppStep.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case start
    case contacts
    case contactDetails(contact: PhoneContact)
    
    case back
}
