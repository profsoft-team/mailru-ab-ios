//
//  AppDelegate.swift
//  AddressBook
//
//  Created by Дмитрий Яровой on 11/26/20.
//

import UIKit
import Then
import RxSwift
import RxFlow

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appFlow: AppFlow!
    let coordinator = FlowCoordinator()
    private let disposeBag = DisposeBag()
    private var serviceContainer: ServiceContainer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        serviceContainer = buildService()
        
        guard let window = window else { return false }
        
        appFlow = AppFlow(withWindow: window, service: serviceContainer)
        
        coordinator.rx.didNavigate
            .subscribe(onNext: { flow, step in
                print("did navigate to flow=\(flow) and step=\(step)")
            }).disposed(by: disposeBag)
        
        self.coordinator.coordinate(flow: appFlow, with: AppStepper())
        
        return true
    }
}

private extension AppDelegate {
    
    private func buildService() -> ServiceContainer {
        let phoneContactsService = PhoneContactServiceImpl()
        let conteiner = ServiceContainer(phoneContactsService: phoneContactsService)
        return conteiner
    }
}

