//
//  Router.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 30.03.2024.
//

import UIKit

protocol Router {
    var navigationController: UINavigationController? { get set }
    var builder: Builder? { get set }
}

protocol RouterProtocol: Router {
    func onboardingFlow()
    func authFlow()
    func registerFlow()
    func mainFlow()
}


final class AppRouter: RouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: Builder?
    
    init (navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    
    func onboardingFlow() {
        if let navigationController = navigationController {
            guard let onboardingViewController = builder?.createOnboardingScreen(router: self) else { return }
            navigationController.isNavigationBarHidden = true
            navigationController.viewControllers = [onboardingViewController]
        }
    }
    
    
    func authFlow() {
        if let navigationController = navigationController {
            guard let authViewController = builder?.createAuthScreen(router: self) else { return }
            navigationController.isNavigationBarHidden = true
            navigationController.viewControllers = [authViewController]
        }
    }
    
    
    func mainFlow() {
        if let navigationController = navigationController {
            guard let tabBarViewController = builder?.createMainScreen(router: self) else { return }
            navigationController.isNavigationBarHidden = true
            navigationController.viewControllers = [tabBarViewController]
        }
    }

    
    func registerFlow() {
        if let navigationController = navigationController {
            guard let registerViewController = builder?.createRegisterScreen(router: self) else { return }
            navigationController.isNavigationBarHidden = true
            navigationController.viewControllers = [registerViewController]
        }
    }
}
