//
//  StatementTableViewCell.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    // Define your UI elements
    let cardView: UIView = {
        let view = UIView()
        // Customize card view properties
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 100)
        view.backgroundColor = UIColor(named: "EBackground")
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 6
        return view
    }()
    
    // Define your UI elements
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "EAccent")
        
        // Add rectangle overlay without fill
            let overlayView = UIView()
            overlayView.layer.borderWidth = 1
            overlayView.layer.borderColor = UIColor.gray.cgColor
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(overlayView)
            
            // Center the overlay view in the iconImageView
            NSLayoutConstraint.activate([
                overlayView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                overlayView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                overlayView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.8),
                overlayView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
            ])
        
        return imageView
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    let datetimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        // Customize datetime label properties
        return label
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(named: "EAccent")
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fill
        // Customize stack view properties
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure the cell's UI
        contentView.addSubview(cardView)
        
        cardView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add UI elements to the stack view
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(verticalStackView())
        stackView.addArrangedSubview(balanceLabel)
        
        // Add constraints for the UI elements
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            messageLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 1/2),
            
            iconImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            
            balanceLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func verticalStackView() -> UIStackView {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fill
        
        verticalStackView.addArrangedSubview(messageLabel)
        verticalStackView.addArrangedSubview(datetimeLabel)
        
        return verticalStackView
    }
}

