//
//  ScanViewController.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import UIKit
import SwiftUI

class ScanViewController: UIHostingController<ScanView> {
    
    init() {
            super.init(rootView: ScanView())
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeView))
        closeButton.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = closeButton
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "EGreen")
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeView() {
        self.dismiss(animated: true, completion: nil)
    }

}

