//
//  ProfileViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 16/07/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileUser: UserModel
    
    init(user: UserModel) {
            self.profileUser = user
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // MARK: - UI Components
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.setImage(with: profileUser.image)
        image.backgroundColor = UIColor.secondarySystemBackground
        image.clipsToBounds = true
        image.layer.cornerRadius = 65
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var verifiedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Verified"
        return label
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "\(profileUser.firstName) \(profileUser.lastName)"
        return label
    }()

    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = String(profileUser.exp ?? 9800000000)
        return label
    }()

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.configireNavigationBar()
        self.configureBlobShape()
        self.configureCardView()
    }
    
    func configireNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    func configureProfileView() {
        
    }
    
    func configureBlobShape() {
        let blobView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/2))
        blobView.backgroundColor = UIColor(named: "EGreen")
        let cornerRadius: CGFloat = 100
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: blobView.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        blobView.layer.mask = maskLayer
        view.addSubview(blobView)
        
        // Create vertical stack view
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 2.0
        blobView.addSubview(mainStackView)
        
        let verifiedStackView = UIStackView()
        verifiedStackView.axis = .horizontal
        verifiedStackView.alignment = .center
        verifiedStackView.spacing = 5.0
        
        verifiedStackView.addArrangedSubview(verifiedLabel)
        
        mainStackView.addArrangedSubview(avatarImage)
        mainStackView.addArrangedSubview(fullNameLabel)
        mainStackView.addArrangedSubview(phoneNumberLabel)
        mainStackView.addSubview(verifiedStackView)
        
        // Set constraints for the stack view
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: blobView.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: blobView.centerYAnchor),
            
            avatarImage.widthAnchor.constraint(equalTo: blobView.widthAnchor, multiplier: 0.3),
            avatarImage.heightAnchor.constraint(equalTo: blobView.widthAnchor, multiplier: 0.3),

        ])
    }
    
    
    func configureCardView() {
        let cardView = UIView(frame: CGRect(x: 20, y: view.bounds.height/2.3, width: view.bounds.width - 40, height: 80))
        cardView.backgroundColor = UIColor(named: "EBackground")
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.05
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 6
        
        // Add the card view as a subview to the main view
        view.addSubview(cardView)
        
        let buttonWidth = cardView.bounds.width / 4
        let buttonHeight: CGFloat = 70
        
        // MARK: - Top Section
        let topSectionView = UIView(frame: CGRect(x: 0, y: 0, width: cardView.bounds.width, height: 80))
        
        topSectionView.backgroundColor = UIColor(named: "EBackground")
        topSectionView.layer.cornerRadius = 10
        
        //            let maskLayer = CAShapeLayer()
        //            maskLayer.path = UIBezierPath(roundedRect: topSectionView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        //            topSectionView.layer.mask = maskLayer
        
        let leadingButton = createButton(title: "Rs. XXXX.xxx", subTitle: "Balance", imageName: "tray")
        
        
        let trailingButton = createButton(title: "18.02", subTitle: "Reward Point", imageName: "bookmark.circle")
        
        let stackView = UIStackView(arrangedSubviews: [leadingButton, trailingButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        
        topSectionView.addSubview(stackView)
        
        // Set up constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topSectionView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: topSectionView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: topSectionView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: topSectionView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: topSectionView.heightAnchor),
            
        ])
        
        
        cardView.addSubview(topSectionView)
    }
    
    func createButton(title: String?, subTitle: String?, imageName: String) -> UIButton {
        let button = UIButton()
        
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "EAccent")
        
        
        let titleLabel = UILabel()
        titleLabel.text = " Rs. XXXX.xx"
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textAlignment = .center
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = subTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        subTitleLabel.textAlignment = .center
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.spacing = 4
        
        let horizontalStackView = UIStackView(arrangedSubviews: [imageView, verticalStackView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        
        button.addSubview(horizontalStackView)
        
        // Set up constraints for the horizontal stack view
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: button.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: button.bottomAnchor)
        ])
        
        
        return button
    }
    
}
