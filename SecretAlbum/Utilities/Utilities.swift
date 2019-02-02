//
//  Utilities.swift
//  SecretAlbum
//
//  Created by Jash on 2018/12/24.
//  Copyright © 2018 Jash. All rights reserved.
//

import UIKit
import DateToolsSwift

class Utilities {
    
    class func openOSSetting(title: String) {
        let alert = UIAlertController(title: "", message: NSLocalizedString("iOS系统设置[" + title + "]项未打开，请先去设置。", comment: ""), preferredStyle: .alert)
        let cancel = UIAlertAction(title: NSLocalizedString("暂时不要", comment: ""), style: .cancel) { (action) in
        }
        let goSetting = UIAlertAction(title: NSLocalizedString("去设置", comment: ""), style: .default) { (action) in
            let url = URL(string: UIApplication.openSettingsURLString)!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(goSetting)
        alert.presentOnTop(animated: true)
    }
    
    class func createImageFromColor(_ color: UIColor) -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func formatDate(group: PhotoGroup) -> String {
        return formatDate(date: group.date)
    }
    
    class func formatDate(date: Date) -> String {
        return String(date.month) + "月" + String(date.day) + "日" + "  " + String(date.year)
    }
    
    
}
