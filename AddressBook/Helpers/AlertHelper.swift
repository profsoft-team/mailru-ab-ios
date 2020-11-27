//
//  AlertHelper.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/27/20.
//

import UIKit

typealias AlertButtonAction = (_: UIAlertAction) -> Void

class AlertHelper {
    
    class func alertError(message: String?) -> UIAlertController {
        let alert = self.alert(title: R.string.localizable.error(),
                               message: message)
        let cancelAction = UIAlertAction(title: R.string.localizable.okButton(),
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    class func alertErrorWithAction(message: String?,
                                    action: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alert = self.alert(title: R.string.localizable.error(),
                               message: message)
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(),
                                         style: .cancel,
                                         handler: nil)
        let okAction = UIAlertAction(title: R.string.localizable.showSettings(),
                                     style: .default,
                                     handler: action)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        return alert
    }
    
    
    private class func alert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        return alert
    }
}
