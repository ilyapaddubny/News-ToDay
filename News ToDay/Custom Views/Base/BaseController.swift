//
//  BaseController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.

import UIKit


enum NavBarPosition {
    case left
    case right
}


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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}



@objc extension BaseController {
    
    func addViews() {
        view.addSubviews(subtitle)
    }
    
    func constraintViews() {
        let offset: CGFloat = 16
        
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
    
    
    func navBarLeftButtonHandler() {
        print("NavBar left button tapped")
    }
    
    func navBarRightButtonHandler() {
        print("NavBar right button tapped")
    }
}


extension BaseController {
    func addNavBarButton(at position: NavBarPosition, with image: UIImage) {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    
    func setTitleForNavBarButton(_ title: String, at position: NavBarPosition) {
        
        switch position {
        case .left:
            (navigationItem.leftBarButtonItem?.customView as? UIButton)?.setTitle(title, for: .normal)
        case .right:
            (navigationItem.rightBarButtonItem?.customView as? UIButton)?.setTitle(title, for: .normal)
        }
        navigationController?.view.layoutSubviews()
        view.layoutSubviews()
    }
    
    
}
