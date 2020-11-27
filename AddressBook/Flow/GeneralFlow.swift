//
//  GeneralFlow.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import RxFlow

final class GeneralFlow: Flow {
    
    private let serviceConteiner: ServiceContainer
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.prefersLargeTitles = true
        return viewController
    }()
    
    init(serviceConteiner: ServiceContainer) {
        self.serviceConteiner = serviceConteiner
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .contacts:
            return navigationToContactsScreen()
        case let .contactDetails(contact):
            return navigationToContactDetailsScreen(contact: contact)
        default:
            return .none
        }
    }
    
    private func navigationToContactsScreen() -> FlowContributors {
        let viewController = ContactsViewController.instantiate()
        let viewModel = ContactsViewModel(phoneContactsService: serviceConteiner.phoneContactsService)
        viewController.inject(viewModel: viewModel)
        viewController.title = R.string.localizable.contactScreenTitle()
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: viewController,
                                                                withNextStepper: viewModel))
    }
    
    private func navigationToContactDetailsScreen(contact: PhoneContact) -> FlowContributors {
        let viewController = ContactDetailsViewController.instantiate()
        let viewModel = ContactDetailsViewModel(contact: contact)
        viewController.inject(viewModel: viewModel)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: viewController,
                                                                withNextStepper: viewModel))
    }
}

