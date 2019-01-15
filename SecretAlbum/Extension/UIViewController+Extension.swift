//
//  UIViewController+Extension.swift
//  SecretAlbum
//
//  Created by Jash on 2018/12/24.
//  Copyright © 2018 Jash. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentOnTop(animated: Bool, completion: (() -> Void)? = nil) {
        if var topVC = (UIApplication.shared.delegate as? AppDelegate)?.navigationController.viewControllers.last {
            while topVC.presentedViewController != nil {
                topVC = topVC.presentedViewController!
            }
            topVC.present(self, animated: animated, completion: completion)
        }
    }
}
