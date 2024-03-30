//
//  ModuleBuilder.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 30.03.2024.
//

import UIKit

protocol Builder {
    func createOnboardingScreen(router: RouterProtocol) -> UIViewController
    func createAuthScreen(router: RouterProtocol) -> UIViewController
    func createRegisterScreen(router: RouterProtocol) -> UIViewController
    func createMainScreen(router: RouterProtocol) -> UITabBarController
}

final class ModuleBuilder: Builder {
    
    
    func createMainScreen(router: RouterProtocol) -> UITabBarController {
        let view = NTDTabBarController(router: router)
        return view
    }
    
    
    func createOnboardingScreen(router: RouterProtocol) -> UIViewController {
        let view = OnboardingViewController()
        view.router = router
        return view
    }
    
    
    func createAuthScreen(router: RouterProtocol) -> UIViewController {
        let view = SignInViewController()
        view.router = router
        return view
    }
    
    
    func createRegisterScreen(router: RouterProtocol) -> UIViewController {
        let view = SignUpViewController()
        view.router = router
        return view
    }
    
}
