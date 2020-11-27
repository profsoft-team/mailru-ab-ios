//
//  String + Extensions.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation

extension String {
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func onlyPhoneNumbers() -> String {
        return self.replace(string: " ", replacement: "")
            .replace(string: "(", replacement: "")
            .replace(string: ")", replacement: "")
            .replace(string: "+", replacement: "")
    }
}
