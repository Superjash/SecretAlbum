//
//  AppDelegate.swift
//  SecretAlbum
//
//  Created by Jash on 2018/12/24.
//  Copyright © 2018 Jash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    internal var tabBarController: UITabBarController!
    
    internal var wcVC: WeirdCameraViewController!
    internal var saVC: SecretAlbumViewController!
    internal var ecVC: EatCrabViewController!
    
    internal var navigationController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initTabBar()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func initTabBar() {
        tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = UIColor(red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1.0)
        
        navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        wcVC = WeirdCameraViewController()
        wcVC.tabBarItem = UITabBarItem(title: "Camera", image: nil, tag: 0)
        
        saVC = SecretAlbumViewController()
        saVC.tabBarItem = UITabBarItem(title: "Album", image: nil, tag: 1)
        
        ecVC = EatCrabViewController()
        ecVC.tabBarItem = UITabBarItem(title: "Eat Crab", image: nil, tag: 2)
        
        navigationController.setViewControllers([tabBarController], animated: false)
        tabBarController.viewControllers = [wcVC, saVC, ecVC]
        
        tabBarController.selectedIndex = 2
    }
}
