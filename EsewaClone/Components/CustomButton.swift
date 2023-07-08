//
//  CustomButton.swift
//  EsewaClone
//
//  Created by Alin Khatri on 24/06/2023.
//

import UIKit

class CustomButton: UIButton {
    
    var onButtonTap: ((String) -> Void)?

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "EAccent")
        return imageView
    }()
    
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    init(title: String, imageName: String, titleWeight: CGFloat) {
        super.init(frame: .zero)
        
        iconImageView.image = UIImage(systemName: imageName)
        optionLabel.text = title
        optionLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: titleWeight))
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addSubview(iconImageView)
        addSubview(optionLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        // Disable autoresizing mask translation
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints for the iconImageView
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Add constraints for the titleLabel
        optionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        optionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        optionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        optionLabel.numberOfLines = 2
    }
    
    @objc private func buttonTapped() {
        onButtonTap?(optionLabel.text ?? "")
    }
}
