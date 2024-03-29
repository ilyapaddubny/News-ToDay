//
//  ProfileViewController.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 18.03.2024.
//

import UIKit

class ProfileViewController: BaseController {
    
    var langLabel: UILabel!
    var termsLabel: UILabel!
    var signOutLabel: UILabel!
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setUserText()
        setLabelsText()
        setBtn()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private lazy var btnStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var image: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "ProfileImage")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        image.widthAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.textSecondaryColor.cgColor
        image.layer.masksToBounds = false
        image.layer.cornerRadius = view.frame.height/20
        image.clipsToBounds = true
        
        return image
    }()
    
   
    
    private func setImage() {
        self.view.addSubview(image)
        image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setUserText() {
        self.view.addSubview(textStack)
        
        let userName = createLabel(size: 20, font: "Inter-SemiBold", text: "Ivan I", color: .textPrimaryColor)
        let userMail = createLabel(size: 17, font: "Inter-Regular", text: "Ivan@gmail.com", color: .textSecondaryColor)
        
        textStack.addArrangedSubview(userName)
        textStack.addArrangedSubview(userMail)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/20 - 10),
            textStack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20)
            
        ])
    }
    
    private func setLabelsText() {
        langLabel = createLabel(size: 17, font: "Inter-SemiBold", text: ProfileStrings.language, color: .textOnDisabledButtonColor)
        termsLabel = createLabel(size: 17, font: "Inter-SemiBold", text: ProfileStrings.termsAndConditions, color: .textOnDisabledButtonColor)
        signOutLabel = createLabel(size: 17, font: "Inter-SemiBold", text: ProfileStrings.signOut, color: .textOnDisabledButtonColor)
    }
        
    
    private func setBtn() {
        setLabelsText()
        let langBtn = createButton(action: langAct())
        let termsBtn = createButton(action: termsAct())
        let signOutBtn = createButton(action: signAct())
        
        self.view.addSubview(btnStack)
        
        self.view.addSubview(langBtn)
        self.view.addSubview(langLabel)
        self.view.addSubview(termsLabel)
        self.view.addSubview(signOutLabel)
//        self.view.addSubview(langImg)
      
        btnStack.addArrangedSubview(termsBtn)
        btnStack.addArrangedSubview(signOutBtn)
        
        NSLayoutConstraint.activate([
            btnStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            btnStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            btnStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            langBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            langBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            langBtn.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            
            langLabel.leadingAnchor.constraint(equalTo: langBtn.leadingAnchor, constant: 20),
            langLabel.topAnchor.constraint(equalTo: langBtn.topAnchor, constant: 18),
            
            termsLabel.leadingAnchor.constraint(equalTo: termsBtn.leadingAnchor, constant: 20),
            termsLabel.topAnchor.constraint(equalTo: termsBtn.topAnchor, constant: 18),
            
            signOutLabel.leadingAnchor.constraint(equalTo: signOutBtn.leadingAnchor, constant: 20),
            signOutLabel.topAnchor.constraint(equalTo: signOutBtn.topAnchor, constant: 18),
            
        ])
       
        
    }
    


    private func createLabel(size: CGFloat, font: String, text: String, color: UIColor) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        
        return label
    }
    
    private func createButton(action: UIAction) -> UIButton {
        
        let button = UIButton(primaryAction: action)
//        button.setTitleColor(.textOnDisabledButtonColor, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 20)
        button.layer.cornerRadius = 15
        button.backgroundColor = .buttonDisabledColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return button
        
    }
    
    func langAct() -> UIAction {
        let act = UIAction { _ in
            let vc = LanduageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return act
    }
    
    func termsAct() -> UIAction {
        let act = UIAction { [weak self] _ in
            let vc = TermsConditionsController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return act
    }
    
    func signAct() -> UIAction {
        let act = UIAction { [weak self] _ in
            let vc = SignInViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return act
    }
    
}
