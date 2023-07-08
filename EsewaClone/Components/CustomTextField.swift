//
//  CustomTextField.swift
//  EsewaClone
//
//  Created by Alin Khatri on 26/06/2023.
//

import UIKit

class CustomTextField: UITextField {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // Set up the icon image view
        rightViewMode = .always
        rightView = iconImageView
        
        // Add padding to the text field
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        
        // Configure border and background colors
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        layer.cornerRadius = 12
        backgroundColor = UIColor.secondarySystemBackground
        
        // Add a target to handle editing events
        addTarget(self, action: #selector(textFieldEditingBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldEditingEnd), for: .editingDidEnd)
    }
    
    @objc private func textFieldEditingBegin() {
        // Change the border and background colors when editing begins
        layer.borderColor = UIColor(named: "EAccent")?.cgColor
        backgroundColor = UIColor(named: "EAccent")?.withAlphaComponent(0.1)
    }
    
    @objc private func textFieldEditingEnd() {
        // Change the border and background colors when editing ends
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
        backgroundColor = UIColor.secondarySystemBackground
    }
    
    var textData: String? {
        return text
    }
    
    
}

