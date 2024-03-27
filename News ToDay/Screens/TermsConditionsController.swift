//
//  TermsConditionsController.swift
//  News ToDay
//
//  Created by Дарья Большакова on 22.03.2024.
//

import UIKit

class TermsConditionsController: UIViewController {
    let logoLabel = UILabel()
    let termsLabel = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: back())
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .textSecondaryColor
        button.heightAnchor.constraint(equalToConstant: 15).isActive = true
        button.widthAnchor.constraint(equalToConstant: 15).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setUI()
        view.backgroundColor = .white
    }
    
    func setUI() {
        
        
        
        logoLabel.text = ("Terms & Conditions")
        logoLabel.font = UIFont(name: "Inter-SemiBold" , size: 25)
        logoLabel.textColor = .textPrimaryColor
        logoLabel.textAlignment = .center
        
        termsLabel.text = termsConditions
        termsLabel.font = UIFont(name: "Inter-Regular" , size: 15)
        termsLabel.textColor = .textSecondaryColor
        termsLabel.isEditable = false
        termsLabel.isSelectable = false
        
       
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoLabel)
        view.addSubview(termsLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            logoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            
            termsLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10),
            termsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            termsLabel.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            termsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ])
    }
    
    func back() -> UIAction {
        let act = UIAction { _ in
            print(4)
            self.navigationController?.popViewController(animated: true)
//            let vc = ProfileViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        return act
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
