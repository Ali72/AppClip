//
//  AppDelegate.swift
//  IcePack
//
//  Created by nixzhu on 2017/7/13.
//  Copyright © 2017年 nixWork. All rights reserved.
//

import UIKit
import AppClip

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        AppClip.create()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
}
