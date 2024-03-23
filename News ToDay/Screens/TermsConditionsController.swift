//
//  TermsConditionsController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 22.03.2024.
//

import UIKit

class TermsConditionsController: UIView {
    let logoLabel = UILabel()
    let termsLabel = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let backButton = UIButton()
    
    init() {
        super.init(frame: CGRect())
        setUI()
        
    }
    
    
    func setUI() {
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .textSecondaryColor
        backButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        logoLabel.text = ("Terms & Conditions")
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .center
        
        termsLabel.text = termsConditions
        termsLabel.font = UIFont(name: "Inter-Regular" , size: 15)
        termsLabel.textColor = .textSecondaryColor
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(logoLabel)
        addSubview(termsLabel)
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            logoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            
            termsLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10),
            termsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termsLabel.trailingAnchor.constraint(equalTo:safeAreaLayoutGuide.trailingAnchor, constant: -20),
            termsLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import SwiftUI

struct viewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = TermsConditionsController()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
