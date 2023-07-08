//
//  SupportViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import UIKit

class SupportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.setupNavBar()
        self.setupFAB()
    }
    
    private func setupNavBar() {
        
        // Set the status bar background color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor(named: "EGreen")
        view.addSubview(statusBarView)
        
        navigationController?.navigationBar.backgroundColor = UIColor(named: "EGreen")
        
        self.title = "Help and Support"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: nil)
        filterBarButton.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = filterBarButton
    }
    
    private func setupFAB() {
            
        let floatingButton = CustomFloatingActionButton()
        
        floatingButton.backgroundColor = UIColor.red
        
        floatingButton.configure(icon: UIImage(systemName: "plus"), title: "Add") {
            print("hello")
        }
        
        
        view.addSubview(floatingButton)

        // Set the constraints for the floating action button
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true

    }
}
