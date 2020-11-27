//
//  BaseViewController.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit
import Reusable

class BaseViewController<T: Transformatable>: UIViewController, StoryboardBased {
    
    var viewModel: T!
    
    func inject(viewModel: T) {
        self.viewModel = viewModel
    }
}
