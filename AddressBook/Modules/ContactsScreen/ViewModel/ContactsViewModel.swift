//
//  ContactsViewModel.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

struct ContactsViewModelInput {
    let cellTap: Observable<PhoneContact>
}

struct ContactsViewModelOutput {
    let items: Driver<[PhoneContact]>
    let showError: Driver<(message: String, isShowSetting: Bool)>
}

final class ContactsViewModel: Stepper {
    
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let phoneContactsService: PhoneContactService
    
    init(phoneContactsService: PhoneContactService) {
        self.phoneContactsService = phoneContactsService
    }
}

extension ContactsViewModel: Transformatable {
    
    func transform(input: ContactsViewModelInput) -> ContactsViewModelOutput {
        let showError = PublishRelay<(message: String, isShowSetting: Bool)>()
        
        input.cellTap
            .map { AppStep.contactDetails(contact: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        let items = phoneContactsService
            .getContacts()
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .materialize()
            .map({ event -> Event<[PhoneContact]> in
                if case let .error(error) = event {
                    showError.accept((error.localizedDescription, (error as NSError).code == 100))
                    return .completed
                } else {
                    return event
                }
            })
            .dematerialize()
            .asDriver(onErrorJustReturn: [])
        
        let output = ContactsViewModelOutput(items: items,
                                             showError: showError.asDriver(onErrorDriveWith: .never()))
        return output
    }
}
