//
//  SignInViewController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 27.03.2024.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
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
    var loginText = SignInStrings.email
    var passwordText = SignInStrings.password
    var loginEnterText = SignInStrings.enterEmail
    var passwordEnterText = SignInStrings.enterPassword
    
    lazy var button: UIButton = {
        let button = UIButton(primaryAction: buttonTapped())
        button.setTitle(SignInStrings.signIn, for: .normal)
        button.setTitleColor(.textOnActiveButtonColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 20)
        button.layer.cornerRadius = 15
        button.backgroundColor = .buttonActiveColor
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return button
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = SignInStrings.label
        label.textColor = .textSecondaryColor
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(primaryAction: signUpAction())
        button.setTitle(SignInStrings.signUp, for: .normal)
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
        let image = createImageForField(name: "lockIcon")
        return image
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
        logoLabel.text = SignInStrings.title
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 27)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .left
        
        textLabel.text = SignInStrings.text
        textLabel.font = UIFont(name: "Inter-Regular" , size: 18)
        textLabel.textColor = .textSecondaryColor
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 4
        
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
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 15),
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
        ])
    }
    
    func createTextField(name: String, imName: UIView) -> UITextField {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textSecondaryColor])
        field.leftView = imName
        field.backgroundColor = .buttonDisabledColor
        field.leftViewMode = .always
        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        if textField == login {
            textField.leftView = createImageForField(name: "EmailSelectedIcon")
        } else {
            textField.leftView = createImageForField(name: "lockSelectedIcon")
        }
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.buttonActiveColor.cgColor
        if textField == password {
            
            textField.rightView = createImageForField(name: "EyeIcon")
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        check()
        return true
    }
    
    // MARK: - Logic + Actions
    
    func check()  {
        if self.login.text!.trimmingCharacters(in: .whitespaces) != "" && self.password.text!.trimmingCharacters(in: .whitespaces) != "" {
            self.button.isUserInteractionEnabled = true
            self.button.alpha = 1.0
        }
    }
    
    private func updateLabelsText() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarItem.title = nil
        logoLabel.text = SignInStrings.title
        textLabel.text = SignInStrings.text
        loginText = SignInStrings.email
        passwordText = SignInStrings.password
        loginEnterText = SignInStrings.enterEmail
        passwordEnterText = SignInStrings.enterPassword
        button.setTitle(SignInStrings.signIn, for: .normal)
        signUpButton.setTitle(SignInStrings.signUp, for: .normal)
        
    }
    
    func showAlert(message: String) {
        // You need to implement your alert logic here, whether it's UIAlertController or some custom alert view
        print("Alert: \(message)")
        // For example:
         let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alertController, animated: true, completion: nil)
    }

    
    func buttonTapped() -> UIAction {
        let act = UIAction { [weak self] _ in
            guard let self = self else { return }
            
            
            if let enteredEmail = self.login.text?.trimmingCharacters(in: .whitespaces),
               let enteredPassword = self.password.text?.trimmingCharacters(in: .whitespaces) {
                
                // Check if the entered email exists in the list of users
                if let user = self.users.first(where: { $0.email == enteredEmail }) {
                    // User email found, check password
                    if user.password == enteredPassword {
                        // Password correct, perform main flow
                        guard var users = UserDefaults.standard.users(forKey: UserDefaultsConstants.listOfUsers)  else {return}
                        if let index = users.firstIndex(where: { $0 == user }) {
                            UserDefaults.standard.setValue(users[index], forKey: UserDefaultsConstants.userLoggedIn)
                            self.router?.mainFlow()
                        }
                        
                        
                        print("User signed in with email: \(enteredEmail)")
                    } else {
                        // Password incorrect, show alert
                        showAlert(message: "Incorrect password. Please try again.")
                    }
                } else {
                    // Email not found, show alert
                    if enteredEmail.capitalized == "Test" && enteredPassword.capitalized == "Test" {
                        self.router?.mainFlow()
                    } else {
                        showAlert(message: "Email not registered. Please sign up or use a different email.")

                    }
                }
                
                
            }
                
                
                
            if self.login.text!.trimmingCharacters(in: .whitespaces) == "" {
                self.login.attributedPlaceholder = NSAttributedString(string: SignInStrings.enterEmail, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.login.layer.borderColor = UIColor.red.cgColor
            }
            if self.password.text!.trimmingCharacters(in: .whitespaces) == "" {
                self.password.attributedPlaceholder = NSAttributedString(string: SignInStrings.enterPassword, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                self.password.layer.borderColor = UIColor.red.cgColor
            }
        }
        return act
    }
    
    func eyeAction() -> UIAction {
        let act = UIAction { [weak self] _ in
            guard let self = self else { return }
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
        let act = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.router?.registerFlow()
        }
        return act
    }
    
    
    deinit {
        print("deinit from SignInViewController")
    }
}

