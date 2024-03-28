//
//  SignInViewController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 27.03.2024.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    var passwordIsSecure = true
    let logoLabel = UILabel()
    let textLabel = UILabel()
    lazy var button: UIButton = {
        let button = UIButton(primaryAction: buttonTapped())
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.textOnActiveButtonColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 20)
        button.layer.cornerRadius = 15
        button.backgroundColor = .buttonActiveColor
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .textSecondaryColor
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(primaryAction: signUpAction())
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.textPrimaryColor, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 15).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView()
       
        stack.axis = .horizontal
        stack.spacing = 3
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var eye: UIView = {
        let image = createImageForField(name: "EyeIcon")
        return button
    }()
    
    lazy var  envelope: UIView = {
        let image = createImageForField(name: "EmailIcon")
        return image
    }()
    
    lazy var lock: UIView = {
        let image = createImageForField(name: "LockIcon")
        return image
    }()
    
    lazy var login: UITextField =  {
        let field = createTextField(name: "Email adress", imName: envelope)
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var password: UITextField =  {
        let field = createTextField(name: "Password", imName: lock)
        field.isSecureTextEntry = true
        return field
    }()
    
//    init() {
//        super.init(frame: CGRect())
//        setupUI()
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupUI()
        view.backgroundColor = .white
        login.delegate = self
        login.tag = 0
        password.delegate = self
        password.tag = 1
        
        button.isUserInteractionEnabled = false
        button.alpha = 0.5
        
    }
    
    func setupUI() {
        logoLabel.text = ("Welcome back 👋")
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .left
        
        textLabel.text = ("I am happy to see you again. You can continue where you left off by logging in.")
        textLabel.font = UIFont(name: "Inter-Regular" , size: 18)
        textLabel.textColor = .textSecondaryColor
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 3
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(questionLabel)
        stack.addArrangedSubview(signUpButton)
        
        view.addSubview(logoLabel)
        view.addSubviews(textLabel)
        view.addSubviews(login)
        view.addSubviews(password)
        view.addSubviews(button)
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            login.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            login.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            login.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 60),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
//            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func createTextField(name: String, imName: UIView) -> UITextField {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textSecondaryColor])
       
//        field.placeholder = name
        field.leftView = imName
        field.backgroundColor = .buttonDisabledColor
        field.leftViewMode = .always
        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        field.borderStyle = .roundedRect
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
//        field.layer.borderWidth  = 0.5
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        field.keyboardAppearance = .light
        
        field.translatesAutoresizingMaskIntoConstraints = false
//        field.tintColor = .textSecondaryColor
        return field
    }
    
    func createImageForField(name: String) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 9, width: 25, height: 25))
        let image = UIImage(named: name)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        view.addSubview(imageView)
        return view
    }
    
//    func createButtonForField(name: String, color: UIColor) -> UIView {
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 9, width: 25, height: 25))
//        let image = UIImage(systemName: name)
//        let button = UIButton(primaryAction: self.eyeAction())
////        button.setImage(image, for: .normal)
//        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
////        imageView.addSubview(image)
//        imageView.image = image
////        imageView.backgroundColor = .clear
////        imageView.tintColor = color
//        imageView.contentMode = .scaleAspectFit
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .green
//        view.addSubview(imageView)
//        view.addSubview(button)
//        
//       
//        button.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10).isActive = true
//        button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10).isActive = true
////
//        
//        return view
//    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
             nextField.becomeFirstResponder()
          } else {
             textField.resignFirstResponder()
          }
          return false
       }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
        if textField == login {
            textField.leftView = createImageForField(name: "EmailSelectedIcon")
        } else {
            textField.leftView = createImageForField(name: "LockSelectedIcon")
        }
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.buttonActiveColor.cgColor
        if textField == password {
    
//            var rightButton  = UIButton(primaryAction: act)
//            rightButton.frame = CGRect(x:-5, y:0, width:30, height:30)
//            rightButton.setImage(UIImage(systemName: "eye"), for: .normal)
            textField.rightView = createImageForField(name: "EyeIcon")
//            textField.rightView = rightButton
            textField.rightViewMode = .always
            
            let eyeBtn = UIButton(primaryAction: eyeAction())
            eyeBtn.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(eyeBtn)
            eyeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            eyeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            eyeBtn.topAnchor.constraint(equalTo: password.topAnchor, constant: 10).isActive = true
            eyeBtn.trailingAnchor.constraint(equalTo: password.trailingAnchor, constant: -10).isActive = true
            
        }
    }
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
////        check()
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        check()
        return true
    }
    
    func check()  {
        if self.login.text != "" && self.password.text != "" {
            self.button.isUserInteractionEnabled = true
            self.button.alpha = 1.0
        }
    }
    
    func buttonTapped() -> UIAction {
        let act = UIAction { _ in
            if self.login.text != "" && self.password.text != "" {
                print("sign in")
            }
            if self.login.text == "" {
                self.login.attributedPlaceholder = NSAttributedString(string: "enter your mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.login.layer.borderColor = UIColor.red.cgColor
            }
            if self.password.text == "" {
                self.password.attributedPlaceholder = NSAttributedString(string: "enter your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.password.layer.borderColor = UIColor.red.cgColor
            }
        }
        return act
    }
    
    func eyeAction() -> UIAction {
        let act = UIAction { _ in
            print("eye")
            if self.passwordIsSecure {
                self.passwordIsSecure = false
                self.password.rightView = self.createImageForField(name: "EyeSelectedIcon")
                self.password.isSecureTextEntry = false
            } else {
                self.passwordIsSecure = true
                self.password.rightView = self.createImageForField(name: "EyeIcon")
                self.password.isSecureTextEntry = true
            }
        }
        return act
    }
    
    func signUpAction() -> UIAction {
        let act = UIAction { _ in
            let vc = SignUpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return act
    }
    
}




//uitextfield
//placeholder - текст до введения данных
//borderstyle - разобраться
//clear button - appears while editing ili always
//corrections не нужна?
//spell checking выкл
//keyboard type
//keyboard appearence
//keyboard lock
//auto enable return key
//secure text entry
//смотри метод на скрине для перемещения курсора 

//import SwiftUI
//
//struct Landuage: PreviewProvider {
//    static var previews: some View {
//        ContainerView().ignoresSafeArea()
//    }
//    struct ContainerView: UIViewRepresentable {
//        let view = SignInViewController()
//
//        func makeUIView(context: Context) -> some UIView {
//            return view
//        }
//        func updateUIView(_ uiView: UIViewType, context: Context) { }
//    }
//}
