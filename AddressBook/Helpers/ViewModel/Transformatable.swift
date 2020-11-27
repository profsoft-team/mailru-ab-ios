//
//  File.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation

protocol Transformatable {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
