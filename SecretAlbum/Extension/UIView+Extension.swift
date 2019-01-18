//
//  UIView+Extension.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/17.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Used to layout
    var keyWindowSafeAreaInsets: UIEdgeInsets {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
    
    func setCorner(radius: Int, corner: UIRectCorner) {
        let bezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        let shapLayer = CAShapeLayer()
        shapLayer.frame = self.bounds
        shapLayer.path = bezierPath.cgPath
        
        self.layer.mask = shapLayer
    }
}
