//
//  CustomHeaderCardView.swift
//  EsewaClone
//
//  Created by Alin Khatri on 28/06/2023.
//

import UIKit

class CustomHeaderCardView: UIView {
    // MARK: - Properties
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Configure the card view properties
        backgroundColor = UIColor(named: "EBackground")
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 6
        
        // Add the content stack view as a subview
        addSubview(contentStackView)
        
        // Configure constraints for the content stack view
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Public Methods
    
    func addView(_ view: UIView) {
        contentStackView.addArrangedSubview(view)
    }
    
    func removeView(_ view: UIView) {
        contentStackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
}

