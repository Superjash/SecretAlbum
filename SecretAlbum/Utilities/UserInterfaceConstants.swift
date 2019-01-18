//
//  UserInterfaceConstants.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/17.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

struct UserInterfaceConstants {
    
    static let isXScreenLayout: Bool = {
        //return (UIScreen.main.bounds.width == 375 && UIScreen.main.bounds.height == 812)
        if UIDevice.current.userInterfaceIdiom != .phone {
            return false
        }
        if let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottom > 0 {
            return true
        }
        return false
    }()
    
    static let isSmallScreenLayout: Bool = {
        return UIScreen.main.bounds.width < 350
    }()
    
    static let whiteNavigationBackgroundImage: UIImage? = {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }()
}
