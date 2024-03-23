//
//  UISearchBar+Ext.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 19.03.2024.
//

import UIKit

extension UISearchBar {
    
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    func clearBackgroundColor() {
        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
                subview.alpha = 0
            }
        }
    }
    
    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .medium)
                    newActivityIndicator.color = UIColor.gray
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = textField?.backgroundColor ?? UIColor.white
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width - newActivityIndicator.frame.width / 2,
                                                          y: leftViewSize.height / 2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
    
    func changePlaceholderColor(_ color: UIColor) {
        guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
              let field = textField else {
            return
        }
        for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
            (subview as! UILabel).textColor = color
        }
    }
    
    func setRightImage(normalImage: UIImage,
                       highLightedImage: UIImage) {
        showsBookmarkButton = true
        if let btn = textField?.rightView as? UIButton {
            btn.setImage(normalImage,
                         for: .normal)
            btn.setImage(highLightedImage,
                         for: .highlighted)
        }
    }
    
    func setLeftImage(_ image: UIImage,
                      with padding: CGFloat = 0,
                      tintColor: UIColor) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.tintColor = tintColor
        
        if padding != 0 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: padding).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: padding).isActive = true
            
            let rightPaddingView = UIView()
            rightPaddingView.translatesAutoresizingMaskIntoConstraints = false
            rightPaddingView.widthAnchor.constraint(equalToConstant: padding * 2).isActive = true
            rightPaddingView.heightAnchor.constraint(equalToConstant: padding * 2).isActive = true
            
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(rightPaddingView)
            textField?.leftView = stackView
            
        } else {
            textField?.leftView = imageView
        }
    }
    
    
    func updateHeight(height: CGFloat, radius: CGFloat = 8.0) {
            let image: UIImage? = UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: height))
            setSearchFieldBackgroundImage(image, for: .normal)
            for subview in self.subviews {
                for subSubViews in subview.subviews {
                    if #available(iOS 13.0, *) {
                        for child in subSubViews.subviews {
                            if let textField = child as? UISearchTextField {
                                textField.layer.cornerRadius = radius
                                textField.clipsToBounds = true
                            }
                        }
                        continue
                    }
                    if let textField = subSubViews as? UITextField {
                        textField.layer.cornerRadius = radius
                        textField.clipsToBounds = true
                    }
                }
            }
        }
}
