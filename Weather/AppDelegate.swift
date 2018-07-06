//
//  AppDelegate.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/11/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.shared.saveContext()
    }
}
