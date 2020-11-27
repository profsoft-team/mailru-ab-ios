//
//  AvatarImageView.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit

final class AvatarImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = bounds.height / 2
    }
}
