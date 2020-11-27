//
//  ContactsViewController.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit
import RxSwift

final class ContactsViewController: BaseViewController<ContactsViewModel> {

    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private var input: ContactsViewModelInput!
    private var output: ContactsViewModelOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectRow()
    }
}

private extension ContactsViewController {
    
    func configureUI() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.do {
            $0.register(cellType: ContactTableViewCell.self)
            $0.showsVerticalScrollIndicator = true
            $0.separatorStyle = .singleLine
            $0.backgroundColor = .primaryBackgroundColor
            $0.tableFooterView = UIView()
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
}

private extension ContactsViewController {
    
    func bindUI() {
        bindViewModel()
        bindTableView()
        bindError()
    }
    
    func bindViewModel() {
        let cellTap = tableView.rx.modelSelected(PhoneContact.self).asObservable()
        
        input = ContactsViewModelInput(cellTap: cellTap)
        output = viewModel.transform(input: input)
    }
    
    func bindTableView() {
        output.items.drive(tableView.rx.items(cellIdentifier: ContactTableViewCell.reuseIdentifier,
                                              cellType: ContactTableViewCell.self)) { _, model, cell in
            cell.configureCell(with: model)
        }
        .disposed(by: disposeBag)
    }
    
    func bindError() {
        output.showError
            .drive(onNext: { [unowned self] errorData in
                var alert: UIAlertController
                if errorData.isShowSetting {
                    alert = AlertHelper.alertErrorWithAction(message: R.string.localizable.noAccess(),
                                                             action: { [unowned self] _ in
                                                                self.showSettings()
                                                             })
                } else {
                    alert = AlertHelper.alertError(message: errorData.message)
                }
                self.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

private extension ContactsViewController {
    
    func deselectRow() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
    }
}
