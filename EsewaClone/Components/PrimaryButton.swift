//
//  PrimaryButton.swift
//  EsewaClone
//
//  Created by Alin Khatri on 26/06/2023.
//

import UIKit

class PrimaryButton: UIButton {
    var onPress: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(named: "EAccent")?.withAlphaComponent(0.8)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel?.textColor = .label
        layer.cornerRadius = 12
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        onPress?()
    }
}


