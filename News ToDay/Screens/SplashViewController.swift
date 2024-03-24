//
//  SplashViewController.swift
//  News ToDay
//
//  Created by admins on 22.03.2024.
//

import UIKit

class SplashViewController: UIViewController {

    private let titleFirst: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = UIFont(name: "Adamina-Regular", size: 64)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleSecond: UILabel = {
        let label = UILabel()
        label.text = "ToDay"
        label.font = UIFont(name: "Adamina-Regular", size: 64)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .accentColor

        view.addSubview(titleFirst)
        view.addSubview(titleSecond)
        
        NSLayoutConstraint.activate([
            titleFirst.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 58),
            titleFirst.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            titleFirst.widthAnchor.constraint(equalToConstant: 186),
            titleFirst.heightAnchor.constraint(equalToConstant: 68),
        
            titleSecond.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 121),
            titleSecond.topAnchor.constraint(equalTo: view.topAnchor, constant: 347),
            titleSecond.topAnchor.constraint(equalTo: titleFirst.bottomAnchor, constant: 10)
            ])
        }
     

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let nextViewController = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: nextViewController)
            navigationController.isNavigationBarHidden = true

            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
