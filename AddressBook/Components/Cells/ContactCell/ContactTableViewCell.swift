//
//  ContactTableViewCell.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit
import Reusable

@IBDesignable
final class ContactTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var avatarImageView: AvatarImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureCell(with model: BaseContact) {
        avatarImageView.image = model.avatarImage ?? R.image.defaultAvatar()
        nameLabel.text = model.name
        phoneNumber.isHidden = model.mainPhoneNumber == nil
        phoneNumber.text = model.mainPhoneNumber
    }

}

private extension ContactTableViewCell {
    
    func configureUI() {
        accessoryType = .detailDisclosureButton
        configureLabels()
    }
    
    func configureLabels() {
        nameLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
            $0.textColor = .primaryTextColor
        }
        
        phoneNumber.do {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .secondaryTextColor
        }
    }
}
