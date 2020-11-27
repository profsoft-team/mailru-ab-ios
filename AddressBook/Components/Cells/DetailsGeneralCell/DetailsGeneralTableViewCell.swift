//
//  DetailsGeneralTableViewCell.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit

final class DetailsGeneralTableViewCell: UITableViewCell, CellConfigurable {

    @IBOutlet private weak var avatarImageView: AvatarImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureCell(with model: BaseContact) {
        avatarImageView.image = model.avatarImage ?? R.image.defaultAvatar()
        nameLabel.text = model.name
    }
}

private extension DetailsGeneralTableViewCell {
    
    func configureUI() {
        backgroundColor = .clear
        configureLabels()
    }
    
    func configureLabels() {
        nameLabel.do {
            $0.font = .systemFont(ofSize: 32, weight: .semibold)
            $0.textColor = .primaryTextColor
            $0.textAlignment = .center
            $0.numberOfLines = 3
        }
    }
}
