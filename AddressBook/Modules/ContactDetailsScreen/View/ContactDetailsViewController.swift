//
//  ContactDetailsViewController.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit
import RxSwift

final class ContactDetailsViewController: BaseViewController<ContactDetailsViewModel> {

    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private var input: ContactDetailsViewModelInput!
    private var output: ContactDetailsViewModelOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}

private extension ContactDetailsViewController {
    
    func configureUI() {
        configureTableView()
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .secondaryBackgrounColor
    }
    
    private func configureTableView() {
        tableView.do {
            $0.register(cellType: DetailsGeneralTableViewCell.self)
            $0.register(cellType: PhoneTableViewCell.self)
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
            $0.tableFooterView = UIView()
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
}

private extension ContactDetailsViewController {
    
    func bindUI() {
        bindViewModel()
        bindTableView()
    }
    
    func bindViewModel() {
        let phoneCellTap = tableView.rx.modelSelected(ContactDetailsTableViewItem.self)
            .compactMap { cellModel -> String? in
        
                if case let .phoneNumberCell(model) = cellModel {
                    return model
                } else {
                    return nil
                }
            }
    
        input = ContactDetailsViewModelInput(phoneCellTap: phoneCellTap)
        output = viewModel.transform(input: input)
    }
    
    func bindTableView() {
        output.sections
            .drive(tableView.rx.items(dataSource: output.dataSource))
            .disposed(by: disposeBag)
    }
}
