//
//  UIColor+Extension.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/14.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 参数代表白度，RGB 色值均为 white * 51
    static func saGray(_ white: Int) -> UIColor {
        return UIColor.init(white: CGFloat(white) * 51 / 255, alpha: 1)
    }
    
    /// 玫红色
    static func saMagenta() -> UIColor {
        return UIColor.init(red: 1, green: 30/255.0, blue: 90/255.0, alpha: 1)
    }
    
    /// 橙色
    static func saOrange() -> UIColor {
        return UIColor.init(red: 1, green: 192/255.0, blue: 0, alpha: 1)
    }
    
    /// 蓝色
    static func saBlue() -> UIColor {
        return UIColor.init(red: 0, green: 188/255.0, blue: 1, alpha: 1)
    }
    
    /// 薄荷绿
    static func saMint() -> UIColor {
        return UIColor.init(red: 29/255.0, green: 233/255.0, blue: 182/255.0, alpha: 1)
    }
    
    /// 微信绿
    static func saWechat() -> UIColor {
        return UIColor.init(red: 0, green: 213/255.0, blue: 54/255.0, alpha: 1)
    }
}
