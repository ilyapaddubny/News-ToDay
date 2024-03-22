//
//  BaseController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.

import UIKit

class BaseController: UIViewController {
    var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureViews()
    }
    

}


@objc extension BaseController {
    
    func addViews() {
//        descriptionLabel = UILabel()
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(descriptionLabel)
    }
    
    func constraintViews() {
//        NSLayoutConstraint.activate([
//            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        descriptionLabel.textAlignment = .left
//        descriptionLabel.numberOfLines = 0
//        descriptionLabel.textColor = .textSecondary
//        descriptionLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
    }
}
 

