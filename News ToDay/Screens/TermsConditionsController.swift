//
//  TermsConditionsController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 22.03.2024.
//

import UIKit

class TermsConditionsController: UIViewController {
    let logoLabel = UILabel()
    let termsTextView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    
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
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setUI()
        view.backgroundColor = .white
    }
    
    func setUI() {
        logoLabel.text = ScreenTitleStrings.termsAndConditions
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .center
        


        applyAttributedText()
        
        termsTextView.isEditable = false
        termsTextView.isSelectable = true
        termsTextView.textAlignment = .justified
        termsTextView.textColor = .textSecondaryColor

       
       
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoLabel)
        view.addSubview(termsTextView)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            
            termsTextView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 18),
            termsTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termsTextView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            termsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
    
    func applyAttributedText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 // Add space between lines
        
        var sections = getTranslatedStrings()
        
        

        let attributedText = NSMutableAttributedString()

        for section in sections {
            // Title attributes
            let titleFont = UIFont(name: "Inter-SemiBold", size: 17) ?? UIFont.boldSystemFont(ofSize: 17)
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: titleFont,
                .paragraphStyle: paragraphStyle
            ]
            let attributedTitle = NSAttributedString(string: section.title, attributes: titleAttributes)
            
            // Text attributes
            let textFont = UIFont(name: "Inter-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: textFont,
                .paragraphStyle: paragraphStyle
            ]
            let attributedSectionText = NSAttributedString(string: section.text, attributes: textAttributes)
            
            // Append title and text to attributedText
            attributedText.append(attributedTitle)
            attributedText.append(attributedSectionText)
        }
        
        termsTextView.attributedText = attributedText
    }
    
    func back() -> UIAction {
        let act = UIAction { _ in
            self.navigationController?.popViewController(animated: true)
        }
        return act
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func getTranslatedStrings() -> [(title: String, text: String)] {
        let firstSectionEn = """

These terms and conditions (“Terms”) govern the relationship between you, the user of the News Reader application (the “App”) and the owner of the App, defined as News Reader Inc. (“News Reader”), regarding your use of the App.
        

"""
        let secondSectionEn = """

By downloading, installing, or using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, please do not download, install, or use the App.


"""
        let thirdSectionEn = """

You acknowledge and agree that all intellectual property rights, including but not limited to copyrights, patents, trademarks, and trade secrets, in the App and its content (collectively, the “Content”) belong to News Reader or its licensors. You may not copy, modify, distribute, transmit, display, perform, reproduce, publish, license, sell, rent, sub-license, or otherwise exploit the Content, in whole or in part, without News Reader’s prior written permission.


"""
        let fourthSectionEn = """

The App allows users to submit news articles, photos, videos, or other content (“User Content”). You are solely responsible for the creation, ownership, and legal rights related to the User Content you submit. By submitting User Content to the App, you grant News Reader a non-exclusive, revocable, royalty-free, worldwide license to use, display, distribute, and create derivative works of your User Content in connection with the App, provided that News Reader does not alter the submitted User Content in any way that would constitute misrepresentation.


"""
        let ffifthSectionEn = """

News Reader is not responsible for the accuracy, completeness, or reliability of any Content. You understand that Content may contain errors or omissions, and News Reader expressly disclaims any liability for such errors or omissions. News Reader is also not responsible for User Content or any other content that you or third parties may provide through the App. You use the App at your own risk.

"""
        
        let firstSectionTitleEn = "1. Introduction"
        let secondSectionTitleEn = "2. Acceptance of Terms"
        let thirdSectionTitleEn = "3. Intellectual Property Rights"
        let fourthSectionTitleEn = "4. User Content"
        let fifthSectionTitleEn = "5. Content Disclaimer"
        
        
        let firstSectionRu = """

Эти положения и условия («Условия») регулируют отношения между вами, пользователем приложения News Reader («Приложение»), и владельцем Приложения, определяемым как News Reader Inc. («News Reader»), в отношении вашего использования Приложения.
        

"""
        let secondSectionRu = """

Загружая, устанавливая или используя Приложение, вы подтверждаете, что прочитали, поняли и соглашаетесь соблюдать настоящие Условия. Если вы не согласны с этими Условиями, пожалуйста, не загружайте, не устанавливайте и не используйте Приложение.


"""
        let thirdSectionRu = """

Вы признаете и соглашаетесь с тем, что все права на интеллектуальную собственность, включая, помимо прочего, авторские права, патенты, товарные знаки и коммерческую тайну, в отношении Приложения и его содержимого (совместно именуемого «Контент») принадлежат News Reader или его лицензиарам. Вы не можете копировать, изменять, распространять, передавать, отображать, исполнять, воспроизводить, публиковать, лицензировать, продавать, сдавать в аренду, сублицензировать или иным образом использовать Контент, полностью или частично, без предварительного письменного разрешения News Reader.


"""
        let fourthSectionRu = """

Приложение позволяет пользователям отправлять новостные статьи, фотографии, видео или другой контент («Пользовательский контент»). Вы несете единоличную ответственность за создание, владение и законные права, связанные с Пользовательским контентом, который вы отправляете. Отправляя Пользовательский контент в Приложение, вы предоставляете News Reader неисключительную, отзывную, безвозмездную, всемирную лицензию на использование, отображение, распространение и создание производных работ из вашего Пользовательского контента в связи с Приложением, при условии, что News Reader не изменяет отправленный Пользовательский контент каким-либо образом, что может являться искажением фактов.


"""
        let ffifthSectionRu = """

News Reader не несет ответственности за точность, полноту или надежность любого Контента. Вы понимаете, что Контент может содержать ошибки или упущения, и News Reader прямо отказывается от любой ответственности за такие ошибки или упущения. News Reader также не несет ответственности за Пользовательский контент или любой другой контент, который вы или третьи лица можете предоставить через Приложение. Вы используете Приложение на свой страх и риск.

"""
        
        let firstSectionTitleRu = "1. Введение"
        let secondSectionTitleRu = "2. Принятие Условий"
        let thirdSectionTitleRu = "3. Права на интеллектуальную собственность"
        let fourthSectionTitleRu = "4. Пользовательский контент"
        let fifthSectionTitleRu = "5. Отказ от ответственности "
        
        let stringsEn = [
            (firstSectionTitleEn, firstSectionEn),
            (secondSectionTitleEn, secondSectionEn),
            (thirdSectionTitleEn, thirdSectionEn),
            (fourthSectionTitleEn, fourthSectionEn),
            (fifthSectionTitleEn, ffifthSectionEn)
        ]
        
        let stringsRu = [
            (firstSectionTitleRu, firstSectionRu),
            (secondSectionTitleRu, secondSectionRu),
            (thirdSectionTitleRu, thirdSectionRu),
            (fourthSectionTitleRu, fourthSectionRu),
            (fifthSectionTitleRu, ffifthSectionRu)
        ]
        
        let currentLanguage = UserDefaults.standard.string(forKey: "language")
        
        if let currentLanguage = currentLanguage {
            switch currentLanguage {
            case "Russian":
                return stringsRu
            default:
                return stringsEn
            }
        }
        return stringsEn
    }
    
}


//import SwiftUI
//
//struct viewProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().ignoresSafeArea()
//    }
//    struct ContainerView: UIViewRepresentable {
//        let view = TermsConditionsController()
//        
//        func makeUIView(context: Context) -> some UIView {
//            return view
//        }
//        func updateUIView(_ uiView: UIViewType, context: Context) { }
//    }
//}
    
