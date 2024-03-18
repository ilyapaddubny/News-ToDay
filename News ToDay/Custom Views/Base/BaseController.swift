//
//  BaseController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureViews()
    }
    

}


@objc extension BaseController {
    
    func addViews() {}
    func constraintViews() {}
    func configureViews() {
            view.backgroundColor = .systemBackground
            navigationController?.navigationBar.prefersLargeTitles = true
    }
}
 

