//
//  ContactDetailsDataSource.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import RxDataSources

enum ContactDetailsTableViewItem {
    case generalCell(BaseContact)
    case phoneNumberCell(String)
}

struct ContactDetailsDataSource {
    
    typealias SectionType = SectionModel<String, ContactDetailsTableViewItem>
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    let dataSource = DataSource<SectionType> { dataSource, tableView, indexPath, _ -> UITableViewCell in
        switch dataSource[indexPath] {
        case let .generalCell(model):
            return CellBuilder<DetailsGeneralTableViewCell>.build(tableView: tableView,
                                                                  indexPath: indexPath,
                                                                  model: model)
        case let .phoneNumberCell(model):
            return CellBuilder<PhoneTableViewCell>.build(tableView: tableView,
                                                         indexPath: indexPath,
                                                         model: model)
        }
    }
}
