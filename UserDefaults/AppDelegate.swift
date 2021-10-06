//
//  AppDelegate.swift
//  UserDefaults
//
//  Created by mac on 04.10.2021.
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let userDefaultsViewController = UserDefaultsViewController()
        let navigationController = UINavigationController(rootViewController: userDefaultsViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
