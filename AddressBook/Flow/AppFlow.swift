//
//  AppFlow.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift

final class AppFlow: Flow {
    var root: Presentable {
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    private let serviceConteiner: ServiceContainer
    
    init(withWindow window: UIWindow, service: ServiceContainer) {
        self.rootWindow = window
        self.serviceConteiner = service
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .start:
            return navigationToGeneralFlow()
        default:
            return .none
        }
    }
    
    private func navigationToGeneralFlow() -> FlowContributors {
        let onboardingFlow = GeneralFlow(serviceConteiner: serviceConteiner)
        
        Flows.use(onboardingFlow, when: .created) { root in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: onboardingFlow,
                                                                withNextStepper: OneStepper(withSingleStep: AppStep.contacts)))
    }
}

final class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()

    var initialStep: Step {
        return AppStep.start
    }
}


