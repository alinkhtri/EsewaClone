//
//  TabBarController.swift
//  MST
//
//  Created by Alin Khatri on 14/06/2023.
//

import UIKit

class BottomTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setupTabs()

        self.tabBar.tintColor = UIColor(named: "EAccent")

        self.navigationItem.hidesBackButton = true
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
                if let title = tabBarController.tabBar.items?[index].title, title == "Scan & Pay" {
                    showPageSheet()
                    return false
                }
            }
            return true
        }
    
    private func setupTabs() {

        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let statement = self.createNav(with: "Statement", and: UIImage(systemName: "newspaper"), vc: StatementViewController())
        let scan = self.createNav(with: "Scan & Pay", and: UIImage(systemName: "qrcode"), vc: ScanViewController())
        let payment = self.createNav(with: "My Payments", and: UIImage(systemName: "doc.plaintext"), vc: MyPaymentsViewController())
        let support = self.createNav(with: "Support", and: UIImage(systemName: "questionmark.bubble"), vc: SupportViewController())

        self.setViewControllers([home, statement, scan, payment, support], animated: true)
    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        
        return nav
    }
    
    @objc private func showPageSheet() {
        let vcToPresent = ScanViewController()
        let pageSheet = UINavigationController(rootViewController: vcToPresent)
        pageSheet.modalPresentationStyle = .pageSheet
        // Customize any additional properties of the pageSheet
        
        // Present the pageSheet
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(pageSheet, animated: true, completion: nil)
        }
    }


}
