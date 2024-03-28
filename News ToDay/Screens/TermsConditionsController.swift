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
    
    var textExample: String = ""
    
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
        textExample =  NSLocalizedString("fifthSection", value: """
                                                
                                                News Reader is not responsible for the accuracy, completeness, or reliability of any Content. You understand that Content may contain errors or omissions, and News Reader expressly disclaims any liability for such errors or omissions. News Reader is also not responsible for User Content or any other content that you or third parties may provide through the App. You use the App at your own risk.
                                                
                                                """, comment: "Terms And Conditions").localized
        
        
        termsTextView.text = textExample
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
        


//        applyAttributedText()
        
        termsTextView.isEditable = false
        termsTextView.isSelectable = true
        termsTextView.textAlignment = .justified
        termsTextView.text = textExample
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
        
        
        var sections: [(title: String, text: String)] {[
            (TermsAndConditionsString.firstSectionTitle, TermsAndConditionsString.firstSectionText),
            (TermsAndConditionsString.secondSectionTitle, TermsAndConditionsString.secondSectionText),
            (TermsAndConditionsString.thirdSectionTitle, TermsAndConditionsString.thirdSectionText),
            (TermsAndConditionsString.fourthSectionTitle, TermsAndConditionsString.fourthSectionText),
            (TermsAndConditionsString.fifthSectionTitle, TermsAndConditionsString.fifthSectionText)
        ]}

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
    
