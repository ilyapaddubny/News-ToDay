//
//  LanguageViewController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 22.03.2024.
//

import UIKit

class LanduageViewController: UIViewController {
    
    let logoLabel = UILabel()
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer

    var selectedLanguage = UserDefaults.standard.string(forKey: "language")
    var selectedCountry = UserDefaults.standard.data(forKey: "country")
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: back())
        button.setImage(Image.arrowBackWhite, for: .normal)
        button.tintColor = .textOnDisabledButtonColor
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 26).isActive = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var checkEngIcon: UIView = {
        var view = createIcon(name: "CheckIcon")

        return view
    }()
    
    private lazy var checkRusIcon: UIView = {
        var view = createIcon(name: "CheckIcon")

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setUI()
        setBtn()
        view.backgroundColor = .white
    }
    
    func updateText() {
        logoLabel.text = ScreenTitleStrings.language
        englishLabel.text = LanguageStrings.english
        russianLabel.text = LanguageStrings.russian
        NotificationCenter.default.post(name: NSNotification.Name("updateLanguage"), object: nil)
    }

    func setUI() {
        
        logoLabel.text = ScreenTitleStrings.language
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .center
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
    }
    
    lazy var englishBtn: UIButton = {
        let button = createButton(action: engLang())
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var russianBtn: UIButton = {
        let button = createButton(action: rusLang())
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var englishLabel: UILabel = {
        let label = createLabel(size: 17, font: "Inter-SemiBold", text: LanguageStrings.english, color: .textOnDisabledButtonColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        if selectedLanguage == nil {
            englishBtn.backgroundColor = .buttonActiveColor
            label.textColor = .textOnActiveButtonColor
        } else {
            englishBtn.backgroundColor = ["Английский", "English"].contains(UserDefaults.standard.object(forKey: "language") as? String) ? .buttonActiveColor : .buttonDisabledColor
            label.textColor = ["Английский", "English"].contains(UserDefaults.standard.object(forKey: "language") as? String) ? .textOnActiveButtonColor : .textOnDisabledButtonColor
        }
        
        return label
    }()
    
    lazy var russianLabel: UILabel = {
        let label = createLabel(size: 17, font: "Inter-SemiBold", text: LanguageStrings.russian, color: .textOnDisabledButtonColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        russianBtn.backgroundColor = ["Russian", "Русский"].contains(UserDefaults.standard.object(forKey: "language") as? String) ? .buttonActiveColor : .buttonDisabledColor
        label.textColor = ["Russian", "Русский"].contains(UserDefaults.standard.object(forKey: "language") as? String) ? .textOnActiveButtonColor : .textOnDisabledButtonColor
        
        return label
    }()
    
    func setBtn() {

        view.addSubview(englishBtn)
        view.addSubview(russianBtn)
        view.addSubview(englishLabel)
        view.addSubview(russianLabel)
        
        view.addSubview(checkEngIcon)
        view.addSubview(checkRusIcon)
        
        if selectedLanguage == nil {
            view.sendSubviewToBack(checkRusIcon)
        } else {
            if ["Английский", "English"].contains(UserDefaults.standard.object(forKey: "language") as? String) {
                view.sendSubviewToBack(checkRusIcon)
            } else {
                view.sendSubviewToBack(checkEngIcon)
            }
            
        }
        
        englishLabel.translatesAutoresizingMaskIntoConstraints = false
        russianLabel.translatesAutoresizingMaskIntoConstraints = false
        checkEngIcon.translatesAutoresizingMaskIntoConstraints = false
        checkRusIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            englishBtn.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            englishBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            englishBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            russianBtn.topAnchor.constraint(equalTo: englishBtn.bottomAnchor, constant: 20),
            russianBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            russianBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        
            englishLabel.leadingAnchor.constraint(equalTo: englishBtn.leadingAnchor, constant: 20),
            englishLabel.centerYAnchor.constraint(equalTo: englishBtn.centerYAnchor),
            
            russianLabel.leadingAnchor.constraint(equalTo: russianBtn.leadingAnchor, constant: 20),
            russianLabel.centerYAnchor.constraint(equalTo: russianBtn.centerYAnchor),
            
            checkEngIcon.trailingAnchor.constraint(equalTo: englishBtn.trailingAnchor, constant: -40),
            checkEngIcon.topAnchor.constraint(equalTo: englishBtn.topAnchor, constant: 20),
            
            checkRusIcon.trailingAnchor.constraint(equalTo: russianBtn.trailingAnchor, constant: -40),
            checkRusIcon.topAnchor.constraint(equalTo: russianBtn.topAnchor, constant: 20),
            
        ])
    }
    
    private func createButton(action: UIAction) -> UIButton {
        
        let button = UIButton(primaryAction: action)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
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
    
    func createIcon(name: String) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        let image = UIImage(named: name)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        view.addSubview(imageView)
        
        return view
    }
    
    func back() -> UIAction {
        let act = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        return act
    }
    
    
    func engLang() -> UIAction {
        let act = UIAction { [weak self] _ in
            self?.englishBtn.backgroundColor = .buttonActiveColor
            self?.englishLabel.textColor = .textOnActiveButtonColor
            self?.russianBtn.backgroundColor = .buttonDisabledColor
            self?.russianLabel.textColor = .textOnDisabledButtonColor
            self?.view.sendSubviewToBack(self!.checkRusIcon)
            self?.view.bringSubviewToFront(self!.checkEngIcon)
            UserDefaults.standard.set("English", forKey: "language")
            UserDefaults.standard.set(Country.usa, forKey: "country")
            self?.defaultLocalizer.setSelectedLanguage(lang: "en")
            self?.updateText()
        }
        return act
    }
    
    func rusLang() -> UIAction {
        let act = UIAction { [weak self] _ in
            self?.russianBtn.backgroundColor = .buttonActiveColor
            self?.russianLabel.textColor = .textOnActiveButtonColor
            self?.englishBtn.backgroundColor = .buttonDisabledColor
            self?.englishLabel.textColor = .textOnDisabledButtonColor
            self?.view.bringSubviewToFront(self!.checkRusIcon)
            self?.view.sendSubviewToBack(self!.checkEngIcon)
            UserDefaults.standard.set("Russian", forKey: "language")
            UserDefaults.standard.set(Country.russia, forKey: "country")
            self?.defaultLocalizer.setSelectedLanguage(lang: "ru")
            self?.updateText()
        }
        return act
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
  
}
