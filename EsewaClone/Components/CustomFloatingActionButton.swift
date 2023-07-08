//
//  CustomFloatingActionButton.swift
//  EsewaClone
//
//  Created by Alin Khatri on 30/06/2023.
//

import UIKit

class CustomFloatingActionButton: UIView {
    
    private var action: (() -> Void)?
    
    // Define your UI elements
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
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
        // Configure the view's appearance
        setupView()
        
        // Add subviews and constraints
        addSubview(iconImageView)
        addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupView() {
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupConstraints() {
        // Add constraints for the icon image view
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
        
        // Add constraints for the title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4).isActive = true
    }
    
    // MARK: - Public Methods
    
    func configure(icon: UIImage?, title: String?, action: (() -> Void)?) {
        iconImageView.image = icon
        titleLabel.text = title
        self.action = action
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func handleTapGesture() {
        action?()
    }
}

