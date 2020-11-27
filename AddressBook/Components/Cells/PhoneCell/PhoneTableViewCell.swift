//
//  PhoneTableViewCell.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit

final class PhoneTableViewCell: UITableViewCell, CellConfigurable {

    @IBOutlet private weak var innerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureCell(with model: String) {
        phoneLabel.text = model
    }
}

private extension PhoneTableViewCell {
    
    func configureUI() {
        configureLabels()
        configureView()
    }
    
    func configureView() {
        innerView.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .primaryBackgroundColor
        }
    }
    
    func configureLabels() {
        titleLabel.do {
            $0.font = .systemFont(ofSize: 10)
            $0.textColor = .primaryTextColor
            $0.text = R.string.localizable.phoneTitle()
        }
        
        phoneLabel.do {
            $0.font = .systemFont(ofSize: 17)
            $0.textColor = .linkTextColor
        }
    }
}
