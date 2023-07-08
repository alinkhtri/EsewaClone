//
//  MyPaymentsViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import UIKit

class MyPaymentsViewController: UIViewController {
    
    
    let cardView = CustomHeaderCardView()
    
    let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "calendar.badge.clock")
        imageView.tintColor = UIColor(named: "EAccent")
        return imageView
    }()
    
    let cardHorizontalStackView: UIStackView = {
        let horizontalSV = UIStackView()
        horizontalSV.axis = .horizontal
        horizontalSV.spacing = 20
        return horizontalSV
    }()
    
    let cardVerticalStackView: UIStackView = {
        let verticalSV = UIStackView()
        verticalSV.axis = .vertical
        verticalSV.spacing = 5
        verticalSV.alignment = .leading
        return verticalSV
    }()
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "No payment saved yet!"
        return label
    }()
    
    private let headerSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Once you save a payment, you'll see them here."
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.title = "My Payment"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.setupHeader()
        self.setupCardView()
    }
    
    // MARK: - UI Setup
    private func setupHeader() {
        
        // Create an instance of CustomHeaderView
        let customHeaderView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
        

        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the custom header view as a subview to the main view
        view.addSubview(customHeaderView)
        view.addSubview(cardView)
        
        // Set the status bar background color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "EGreen")
        view.addSubview(statusBarView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            cardView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCardView() {
        
        cardView.addSubview(cardHorizontalStackView)
        
        cardHorizontalStackView.addArrangedSubview(calendarImageView)
        cardHorizontalStackView.addArrangedSubview(cardVerticalStackView)
        
        cardVerticalStackView.addArrangedSubview(headerTitleLabel)
        cardVerticalStackView.addArrangedSubview(headerSubTitleLabel)
        
        cardHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        cardVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
     
        
        NSLayoutConstraint.activate([
        
            cardHorizontalStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            cardHorizontalStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),

            cardHorizontalStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            cardHorizontalStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            
            calendarImageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.12),
            calendarImageView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.12),
            
            cardVerticalStackView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.7)
        ])
    }
}
