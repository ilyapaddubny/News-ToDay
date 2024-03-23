//
//  BaseController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.

import UIKit

class BaseController: UIViewController {
    
    let subtitle = NTDLabel(font: Font.interRegular(with: 16), textColor: .textSecondaryColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureViews()
    }
    
    func setSubtitleText(text: String) {
        subtitle.text = text
    }
}


@objc extension BaseController {
    
    func addViews() {
        view.addSubviews(subtitle)
    }
    
    func constraintViews() {
        let offset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            subtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        subtitle.numberOfLines = 2
        subtitle.text = ""
    }
}


