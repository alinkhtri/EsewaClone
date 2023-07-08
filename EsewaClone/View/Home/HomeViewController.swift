//
//  ViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 24/06/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    private var balance : Int = 10000
    private var reward : Int = 19
    
    private var loginViewModel = LoginViewModel()
    
    let options = [("Topup", "iphone"), ("Electricity", "lightbulb"), ("Khanepani", "drop"), ("eSewa Care", "bolt.heart"), ("Request Money", "indianrupeesign"), ("Internet", "wifi.router"),
                   ("Airlines", "airplane"), ("International Airlines", "globe"), ("Hotels", "building.2"), ("Govt. Payment", "building"), ("Cable Car", "cablecar"), ("Sahakari Deposit", "building.columns"),
                   ("TV", "tv"), ("Education Fee", "graduationcap"), ("Insurance", "umbrella"), ("Financial Services", "dollarsign.circle"), ("Health", "plus.circle"), ("Bus Ticket", "bus"),
                   ("Movies", "play.rectangle"), ("Voting & Events", "menucard"), ("Online Payment", "cart"), ("Antivirus", "shield"), ("Community Electricity", "bolt.batteryblock")]
    
    private var isToggled: Bool = false

    
    // MARK: - UI Components
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.isDirectionalLockEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemBackground
        
        // Set the status bar background color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "EGreen")
        view.addSubview(statusBarView)
        
        navigationController?.navigationBar.backgroundColor = UIColor(named: "EGreen")
        navigationController?.navigationBar.tintColor = UIColor.white
        
        configureNavigationBar()
        configureScrollView()
    }
    
    func configureNavigationBar() {
        // Configure the navigation bar
        
        // Add left bar button item
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "circle.hexagongrid"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        
        // Add right bar button items
        let rightBarButton1 = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(rightBarButton1Tapped))
        let rightBarButton2 = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(rightBarButton2Tapped))
        let rightBarButton3 = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButton3Tapped))
        navigationItem.rightBarButtonItems = [rightBarButton1, rightBarButton2, rightBarButton3]
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.2)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
        
        // Add your subviews to the content view by calling the respective functions
        configureBlobShape(in: contentView)
        
        configureCardView(in: contentView)
        mainCardView(in: contentView)
        
        
    }
    
    
    func configureBlobShape(in contentView: UIView) {
        let blobView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        blobView.backgroundColor = UIColor(named: "EGreen")
        let cornerRadius: CGFloat = 40 // Adjust the value based on your desired corner radius
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: blobView.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        blobView.layer.mask = maskLayer
        contentView.addSubview(blobView)
    }
    
    func configureCardView(in contentView: UIView) {
        let cardView = UIView(frame: CGRect(x: 20, y: 10, width: view.bounds.width - 40, height: 150))
        cardView.backgroundColor = UIColor(named: "EBackground")
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.05
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 6
        
        // Add the card view as a subview to the main view
        contentView.addSubview(cardView)
        
        let buttonWidth = cardView.bounds.width / 4
        let buttonHeight: CGFloat = 70
        
        // MARK: - Top Section
        let topSectionView = UIView(frame: CGRect(x: 0, y: 0, width: cardView.bounds.width, height: 50))
        
        topSectionView.backgroundColor = .secondarySystemBackground
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: topSectionView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        topSectionView.layer.mask = maskLayer
        
        let leadingButton = createButton(title: String(balance), subTitle: "Balance", imageName: "tray")
        
        let middleButton = UIButton()
        middleButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        middleButton.contentMode = .scaleAspectFit
        middleButton.tintColor = .gray
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        
        
        let trailingButton = createButton(title: String(reward), subTitle: "Reward Point", imageName: "bookmark.circle")
        
        let stackView = UIStackView(arrangedSubviews: [leadingButton, middleButton, trailingButton])
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
        
        
        // MARK: - Bottom Section
        let bottomSectionView = UIView(frame: CGRect(x: 0, y: 50, width: cardView.bounds.width, height: buttonHeight))
        cardView.addSubview(bottomSectionView)
        let bottomOptions = [("Load Money", "tray.and.arrow.down"), ("Send Money", "tray.and.arrow.up"), ("Bank Transfer", "building.columns"), ("Remittance", "dollarsign.arrow.circlepath")]
        
        for (index, option) in bottomOptions.enumerated() {
            let x = CGFloat(index) * buttonWidth
            
            let button = CustomButton(title: option.0, imageName: option.1, titleWeight: 0.3)
            button.frame = CGRect(x: x, y: 0, width: buttonWidth, height: 80)
            button.tag = index
            button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            
            bottomSectionView.addSubview(button)
        }
    }
    
    func mainCardView(in contentView: UIView) {
        let cardView = UIView(frame: CGRect(x: 20, y: 190 , width: view.bounds.width - 40, height: 530))
        
        cardView.backgroundColor = UIColor(named: "EBackground")
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.05
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 6
        
        // Add the card view as a subview to the main view
        contentView.addSubview(cardView)
        
        
        // Create a collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: cardView.bounds.width / 4, height: cardView.bounds.height / 6)
        
        // Initialize the collection view
        let collectionView = UICollectionView(frame: cardView.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCell")
        
        // Add the collection view to the card view
        cardView.addSubview(collectionView)
        
        // Set up constraints for the collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cardView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
        
        // Embed the card view into the scroll view
        scrollView.addSubview(cardView)

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
    
    
    
    
    @objc func leftBarButtonTapped() {
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .pageSheet
        present(navController, animated: true, completion: nil)
    }
    
    @objc func rightBarButton1Tapped() {
        // Handle right bar button item 1 tap
    }
    
    @objc func rightBarButton2Tapped() {
        // Handle right bar button item 2 tap
    }
    
    @objc func rightBarButton3Tapped() {
        // Handle right bar button item 3 tap
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        // Handle button tap event
        let optionIndex = sender.tag
        print("Option \(optionIndex + 1) tapped")
    }
    
    // Function called when the eye button is tapped
    @objc func eyeButtonTapped() {
        isToggled.toggle()
        // Perform any additional actions based on the toggled state
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? UICollectionViewCell else {
            fatalError("Failed to dequeue cell")
        }
        
        let option = options[indexPath.item]
        
        // Remove any existing subviews from the cell
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let button = CustomButton(title: option.0, imageName: option.1, titleWeight: 0.2)
        button.frame = cell.contentView.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Assign the closure for button tap action
        button.onButtonTap = { option in
            // Handle the button tap action here
            print("Pressed option: \(option)")
        }
        
        cell.contentView.addSubview(button)
        
        return cell
    }
}

extension HomeViewController {

}
