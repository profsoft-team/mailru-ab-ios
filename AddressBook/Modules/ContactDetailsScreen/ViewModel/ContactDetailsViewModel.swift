//
//  ContactDetailsViewModel.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

struct ContactDetailsViewModelInput {
    let phoneCellTap: Observable<String>
}

struct ContactDetailsViewModelOutput {
    let dataSource = ContactDetailsDataSource().dataSource
    let sections: Driver<[ContactDetailsDataSource.SectionType]>
}

final class ContactDetailsViewModel: Stepper {
    
    let steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private let contact: PhoneContact
    
    init(contact: PhoneContact) {
        self.contact = contact
    }
}

extension ContactDetailsViewModel: Transformatable {
    
    func transform(input: ContactDetailsViewModelInput) -> ContactDetailsViewModelOutput {
        
        input.phoneCellTap
            .callNumber(disposeBag: disposeBag)
        
        let sections = Driver.just(contact)
            .map { ContactDetailsScreenBuilder.build(with: $0) }
            
        let output = ContactDetailsViewModelOutput(sections: sections)
        return output
    }
}

private extension ContactDetailsViewModel {
    
    func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension ObservableType where Element == String {
    
    func callNumber(disposeBag: DisposeBag) {
        self.subscribe(onNext: {
            guard let url = URL(string: "telprompt://\($0.onlyPhoneNumbers())"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        .disposed(by: disposeBag)
    }
}
