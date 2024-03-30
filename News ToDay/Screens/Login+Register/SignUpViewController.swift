//
//  SignUpViewController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 27.03.2024.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var router: RouterProtocol?
    
    var users: [User] {
        get {
            UserDefaults.standard.users(forKey: UserDefaultsConstants.listOfUsers) ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey:  UserDefaultsConstants.listOfUsers)
        }
    }
    
    var passwordIsSecure = true
    let logoLabel = UILabel()
    let textLabel = UILabel()
    var nameText = SignUpStrings.name
    var loginText = SignUpStrings.email
    var passwordText = SignUpStrings.password
    var repeatPasswordText = SignUpStrings.repeatPassword
    var nameEnterText = SignUpStrings.enterName
    var loginEnterText = SignUpStrings.enterEmail
    var passwordEnterText = SignUpStrings.enterPassword
    var repeatPasswordEnterText = SignUpStrings.enterRepeatPassword
    
    lazy var button: UIButton = {
        let button = UIButton(primaryAction: buttonTapped())
        button.setTitle(SignUpStrings.signIn, for: .normal)
        button.setTitleColor(.textOnActiveButtonColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 20)
        button.layer.cornerRadius = 15
        button.backgroundColor = .buttonActiveColor
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return button
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = SignUpStrings.label
        label.textColor = .textSecondaryColor
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(primaryAction: signInAction())
        button.setTitle(SignUpStrings.signIn, for: .normal)
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
    
    lazy var userIcon: UIView = {
        let image = createImageForField(name: "UserIcon")
        return image
    }()
    
    lazy var  envelope: UIView = {
        let image = createImageForField(name: "EmailIcon")
        return image
    }()
    
    lazy var lock: UIView = {
        let image = createImageForField(name: "lockIcon")
        return image
    }()
    
    lazy var lock2: UIView = {
        let image = createImageForField(name: "lockIcon")
        return image
    }()
    
    lazy var userName: UITextField =  {
        let field = createTextField(name: nameText, imName: userIcon)
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var login: UITextField =  {
        let field = createTextField(name: loginText, imName: envelope)
        field.keyboardType = .emailAddress
        return field
    }()
    
    lazy var password: UITextField =  {
        let field = createTextField(name: passwordText, imName: lock)
        field.isSecureTextEntry = true
        return field
    }()
    
    lazy var repeatPassword: UITextField =  {
        let field = createTextField(name: repeatPasswordText, imName: lock2)
        field.isSecureTextEntry = true
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupUI()
        view.backgroundColor = .white
        
        userName.delegate = self
        userName.tag = 0
        login.delegate = self
        login.tag = 1
        password.delegate = self
        password.tag = 2
        repeatPassword.delegate = self
        repeatPassword.tag = 3
        
        
        button.isUserInteractionEnabled = false
        button.alpha = 0.5
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelsText()
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    func setupUI() {
        logoLabel.text = SignUpStrings.title
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 27)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .left
        
        textLabel.text = SignUpStrings.text
        textLabel.font = UIFont(name: "Inter-Regular" , size: 18)
        textLabel.textColor = .textSecondaryColor
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 4
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(questionLabel)
        stack.addArrangedSubview(signInButton)
        
        view.addSubviews(logoLabel)
        view.addSubviews(textLabel)
        view.addSubviews(userName)
        view.addSubviews(login)
        view.addSubviews(password)
        view.addSubviews(repeatPassword)
        view.addSubviews(button)
        view.addSubviews(stack)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 15),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            userName.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            userName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            login.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20),
            login.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            login.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            repeatPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            repeatPassword.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
            
        ])
    }
    
    func createTextField(name: String, imName: UIView) -> UITextField {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textSecondaryColor])
        field.leftView = imName
        field.backgroundColor = .buttonDisabledColor
        field.leftViewMode = .always
        field.heightAnchor.constraint(equalToConstant: 60).isActive = true
        field.layer.cornerRadius = 15
        field.clipsToBounds = true
        field.autocorrectionType = .no
        field.spellCheckingType = .no
        field.keyboardAppearance = .light
        
        field.translatesAutoresizingMaskIntoConstraints = false
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
        switch textField {
        case userName:
            textField.leftView = createImageForField(name: "UserSelectedIcon")
        case login:
            textField.leftView = createImageForField(name: "EmailSelectedIcon")
        case password:
            textField.leftView = createImageForField(name: "lockSelectedIcon")
        case repeatPassword:
            textField.leftView = createImageForField(name: "lockSelectedIcon")
        default:
            break
        }
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.buttonActiveColor.cgColor

    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        check()
    }

    func check()  {
        if self.login.text!.trimmingCharacters(in: .whitespaces) != "" && self.password.text!.trimmingCharacters(in: .whitespaces) != "" && self.userName.text!.trimmingCharacters(in: .whitespaces) != "" && self.repeatPassword.text!.trimmingCharacters(in: .whitespaces) != "" {
            self.button.isUserInteractionEnabled = true
            self.button.alpha = 1.0
        }
    }
    
    private func updateLabelsText() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarItem.title = nil
        logoLabel.text = SignUpStrings.title
        textLabel.text = SignUpStrings.text
        
        nameText = SignUpStrings.name
        loginText = SignUpStrings.email
        passwordText = SignUpStrings.password
        repeatPasswordText = SignUpStrings.repeatPassword
        
        nameEnterText = SignUpStrings.enterName
        loginEnterText = SignUpStrings.enterEmail
        passwordEnterText = SignUpStrings.enterPassword
        repeatPasswordEnterText = SignUpStrings.enterRepeatPassword
        
        button.setTitle(SignUpStrings.signUp, for: .normal)
//        signInButton.setTitle(SignUpStrings.signUp, for: .normal)
        
    }
    
    func buttonTapped() -> UIAction {
        let act = UIAction { [weak self] _ in
            guard let self = self else { return }
            if self.login.text!.trimmingCharacters(in: .whitespaces) == "" {
                self.login.attributedPlaceholder = NSAttributedString(string: SignUpStrings.enterEmail, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.login.layer.borderColor = UIColor.red.cgColor
            }
            if self.password.text!.trimmingCharacters(in: .whitespaces) == "" {
                self.password.attributedPlaceholder = NSAttributedString(string: SignUpStrings.enterPassword, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.password.layer.borderColor = UIColor.red.cgColor
            }
            if self.userName.text!.trimmingCharacters(in: .whitespaces) == "" {
                self.userName.attributedPlaceholder = NSAttributedString(string: SignUpStrings.enterName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.userName.layer.borderColor = UIColor.red.cgColor
            }
            if self.repeatPassword.text!.trimmingCharacters(in: .whitespaces) == "" {
                self.repeatPassword.attributedPlaceholder = NSAttributedString(string: SignUpStrings.enterRepeatPassword, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.repeatPassword.layer.borderColor = UIColor.red.cgColor
            }
            if self.password.text == self.repeatPassword.text {
                //Sign UP here
                guard let name = self.userName.text,
                      let email = self.login.text,
                      let password = self.password.text else {
                    // Handle the case where any of the required fields is nil
                    return
                }
                let newUser = User(name: name, email: email, password: password, fafouriteCategories: [])
                UserDefaults.standard.setValue(newUser, forKey: UserDefaultsConstants.userLoggedIn)
                self.users.append(newUser)
                print("Users in the app: \(self.users)")
                
                guard let router = self.router else { return }
                let onboardingCategoriesViewController = OnboardingCategoriesViewController(router: router)
                self.navigationController?.pushViewController(onboardingCategoriesViewController, animated: true)
                FirstLaunchStorage.setFirstLaunchComplete()
            } else{
                print("nfn")
            }
        }
        return act
    }
    
    func signInAction() -> UIAction {
        let act = UIAction { [weak self] _ in
            self?.router?.authFlow()
        }
        return act
    }
    
    
    deinit {
        print("deinit from SignUpViewController")
    }
}
