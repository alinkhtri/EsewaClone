//
//  UIImageView+Extensions.swift
//  EsewaClone
//
//  Created by Alin Khatri on 16/07/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String) {
        
        guard let url = URL.init(string: urlString) else { return }
        
//        let resource = ImageResource(name: urlString, bundle: nil)
        kf.indicatorType = .activity
//        kf.setImage(with: resource)
    }
}
