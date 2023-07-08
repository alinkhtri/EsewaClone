//
//  StatementViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import UIKit

class StatementViewController: UIViewController {
    
    var dataSource: [StatementItem]!
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.estimatedRowHeight = 80
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        // Set the status bar background color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "EGreen")
        view.addSubview(statusBarView)
        
        configureNavigationBar()
        configureBlobShape()
        configureCardView()
        configureTableView()
        jsonDataParse()
    }
    
    func jsonDataParse() {
        guard let filePath = Bundle.main.url(forResource: "Statement", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: filePath)
            let result = try JSONDecoder().decode(StatementData.self, from: data)
            
            self.dataSource = result.data
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
    
    func configureNavigationBar() {
        // Configure the navigation bar
        self.title = "Statements"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = UIColor(named: "EGreen")
        
        // Add right bar button items
        let rightBarButton1 = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(rightBarButton1Tapped))
        let rightBarButton2 = UIBarButtonItem(image: UIImage(systemName: "arrow.down.doc"), style: .plain, target: self, action: #selector(rightBarButton2Tapped))
        
        navigationItem.rightBarButtonItems = [rightBarButton1, rightBarButton2]
    }
    
    func configureBlobShape() {
        let blobView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 130))
        blobView.backgroundColor = UIColor(named: "EGreen")
        let cornerRadius: CGFloat = 40
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: blobView.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        blobView.layer.mask = maskLayer
        view.addSubview(blobView)
    }
    
    func configureCardView() {
        let cardView = UIView(frame: CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 70))
        cardView.backgroundColor = UIColor(named: "EBackground")
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.05
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 6
        
        // First icon
        let icon1 = UIImageView(image: UIImage(systemName: "tray"))
        icon1.translatesAutoresizingMaskIntoConstraints = false
        icon1.tintColor = UIColor(named: "EAccent")
        cardView.addSubview(icon1)
        
        NSLayoutConstraint.activate([
            icon1.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            icon1.centerXAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            
            icon1.widthAnchor.constraint(equalToConstant: 30),
            icon1.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        // StackView with two labels
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        cardView.addSubview(labelStackView)
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: icon1.trailingAnchor, constant: 15),
            labelStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
        
        let label1 = UILabel()
        label1.text = "Rs. XXXX.xx"
        label1.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelStackView.addArrangedSubview(label1)
        
        let label2 = UILabel()
        label2.text = "Balance"
        label2.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        labelStackView.addArrangedSubview(label2)
        
        // Second icon
        let icon2 = UIImageView(image: UIImage(systemName: "arrow.counterclockwise.circle"))
        icon2.tintColor = UIColor(named: "EAccent")
        icon2.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(icon2)
        
        NSLayoutConstraint.activate([
            icon2.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            icon2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            icon2.widthAnchor.constraint(equalToConstant: 30),
            icon2.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add the card view as a subview to the main view
        view.addSubview(cardView)
    }
    
    func configureTableView() {
        
        // Register the custom table view cell
        tableView.register(StatementTableViewCell.self, forCellReuseIdentifier: "CustomCell")

        tableView.dataSource = self
        tableView.delegate = self
        
        // Add the table view to the view controller's view and set its constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    @objc func rightBarButton1Tapped() {
        // Handle right bar button item 1 tap
    }
    
    @objc func rightBarButton2Tapped() {
        // Handle right bar button item 2 tap
    }
    
}


extension StatementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows based on the data source count
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! StatementTableViewCell
        

        
        let statementItem = dataSource[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: statementItem.datetime)

        dateFormatter.dateFormat = "HH:mm a"
        let formattedTime = dateFormatter.string(from: date ?? Date())
        
        // Configure the custom table view cell with the data from the statementItem
        cell.iconImageView.image = UIImage(systemName: statementItem.icon)
        cell.messageLabel.text = statementItem.message
        cell.datetimeLabel.text = formattedTime
        cell.balanceLabel.text = String(format: "%.2f", statementItem.balance)
        
        // Configure other UI elements in the cell as needed
        
        return cell
    }

}

