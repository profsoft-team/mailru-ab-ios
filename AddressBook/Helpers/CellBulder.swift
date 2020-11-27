//
//  CellBulder.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit
import Reusable

protocol CellConfigurable: NibReusable {
    associatedtype Model
    func configureCell(with model: Model)
}

final class CellBuilder<T: CellConfigurable> where T: UITableViewCell {

    static func build(tableView: UITableView, indexPath: IndexPath, model: T.Model) -> T {
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: T.self)
        cell.configureCell(with: model)
        cell.selectionStyle = .none
        return cell
    }
}

