//
//  PhoneContactsService.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import RxSwift
import RxCocoa
import ContactsUI

protocol PhoneContactService {

    func getContacts() -> Observable<[PhoneContact]>

}

final class PhoneContactServiceImpl: PhoneContactService {

    private let contactStore = CNContactStore()

    func getContacts() -> Observable<[PhoneContact]> {

        var contacts = [PhoneContact]()
        let keys = [
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey,
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName)
            ] as [Any]

        guard let k = keys as? [CNKeyDescriptor] else { return Observable.just([]) }

        return Observable.create({ (observer) -> Disposable in
            let request = CNContactFetchRequest(keysToFetch: k)
            do {
                try self.contactStore.enumerateContacts(with: request) { contact, _ in
                    let phoneContact = PhoneContact(contact: contact)
                    contacts.append(phoneContact)
                }
                observer.onNext(contacts)
            } catch {
                observer.onError(error)
            }

            return Disposables.create()
        })
    }

}
