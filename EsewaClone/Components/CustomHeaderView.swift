//
//  CustomBlobHeader.swift
//  EsewaClone
//
//  Created by Alin Khatri on 28/06/2023.
//

import UIKit

class CustomHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBlobShape()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBlobShape() {
        let blobView = UIView(frame: bounds)
        blobView.backgroundColor = UIColor(named: "EGreen")
        let cornerRadius: CGFloat = 40
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: blobView.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        
        blobView.layer.mask = maskLayer
        addSubview(blobView)
    }
}
