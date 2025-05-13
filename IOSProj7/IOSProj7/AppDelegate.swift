//
//  AppDelegate.swift
//  IOSProj7
//
//  Created by Andy Peralta on 1/24/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if let tabBarController = window?.rootViewController as? UITabBarController {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc  = storyboard.instantiateViewController(withIdentifier: "NavController")
      vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
      tabBarController.viewControllers?.append(vc)
    }
    return true
  }

  // MARK: UISceneSession Lifecycle

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.

  }

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

