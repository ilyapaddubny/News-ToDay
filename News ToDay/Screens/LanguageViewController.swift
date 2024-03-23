//
//  LanguageViewController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 22.03.2024.
//

import UIKit

class LanguageViewController: UIView {
    let logoLabel = UILabel()
    let backButton = UIButton()
    
    
    
    
    init() {
        super.init(frame: CGRect())
        setUI()
        setBtn()
        
    }
    
    
    func setUI() {
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .textSecondaryColor
        backButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        logoLabel.text = ("Language")
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .center
        
        
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(logoLabel)
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            logoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
    }
    
    func setBtn() {
        let englishBtn = createButton()
        let russianBtn = createButton()
        let englishLabel = createLabel(size: 20, font: "Inter-SemiBold", text: "English", color: .textOnDisabledButtonColor)
        let russianLabel = createLabel(size: 20, font: "Inter-SemiBold", text: "Russian", color: .textOnDisabledButtonColor)
        
        englishBtn.backgroundColor = .buttonActiveColor
        englishLabel.textColor = .textOnActiveButtonColor
        
        addSubview(englishBtn)
        addSubview(russianBtn)
        addSubview(englishLabel)
        addSubview(russianLabel)
        
        englishBtn.translatesAutoresizingMaskIntoConstraints = false
        russianBtn.translatesAutoresizingMaskIntoConstraints = false
        englishLabel.translatesAutoresizingMaskIntoConstraints = false
        russianLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            englishBtn.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            englishBtn.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            englishBtn.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            russianBtn.topAnchor.constraint(equalTo: englishBtn.bottomAnchor, constant: 20),
            russianBtn.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            russianBtn.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        
            englishLabel.leadingAnchor.constraint(equalTo: englishBtn.leadingAnchor, constant: 20),
            englishLabel.topAnchor.constraint(equalTo: englishBtn.topAnchor, constant: 18),
            
            russianLabel.leadingAnchor.constraint(equalTo: russianBtn.leadingAnchor, constant: 20),
            russianLabel.topAnchor.constraint(equalTo: russianBtn.topAnchor, constant: 18),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createButton() -> UIButton {
        
        let button = UIButton()
//        button.setTitleColor(.textOnDisabledButtonColor, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 20)
        button.layer.cornerRadius = 15
        button.backgroundColor = .buttonDisabledColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return button
        
    }
    
    private func createLabel(size: CGFloat, font: String, text: String, color: UIColor) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        
        return label
    }
}

import SwiftUI

struct Language: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = LanguageViewController()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
