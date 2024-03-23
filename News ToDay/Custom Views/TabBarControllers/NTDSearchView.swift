//
//  NTDSearchView.swift
//  News ToDay
//
//  Created by Ilya Paddubny on 22.03.2024.
//

import UIKit

class NTDSearchView: UIView {
    
    let mainTextField = UITextField()
    let titleLabel = UILabel()
    
    var text: String? {
        get { mainTextField.text }
        set { mainTextField.text = newValue }
    }
    
    var delegate: UITextFieldDelegate? {
        get { mainTextField.delegate }
        set { mainTextField.delegate = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainTextField()
        configureTitleLabel()

        mainTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // Hide the titleLabel if text is entered in the mainTextField
        titleLabel.isHidden = !textField.text!.isEmpty
    }
    
    private func configureMainTextField() {
        mainTextField.layer.borderWidth = 2
        mainTextField.layer.borderColor = UIColor.darkGray.cgColor
        mainTextField.layer.cornerRadius = 10
        mainTextField.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.frame.width,
                                     height: self.frame.height)
        mainTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        mainTextField.leftViewMode = .always
        mainTextField.returnKeyType = .done
        
        addSubview(mainTextField)
    }

    private func configureTitleLabel() {
        titleLabel.text = " Placeholder "
        titleLabel.textColor = .darkGray
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont(name: "Arial", size: 20)
        titleLabel.frame.size = titleLabel.getTextSize()
//        titleLabel.anchorPoint = CGPoint(x: 0, y: 0)
        titleLabel.frame.origin = CGPoint(x: mainTextField.frame.origin.x + 10,
                                          y: mainTextField.frame.midY - titleLabel.frame.size.height / 2)
        
        addSubview(titleLabel)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

