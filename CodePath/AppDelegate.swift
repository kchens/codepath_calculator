//
//  AppDelegate.swift
//  CodePath
//
//  Created by Kevin Chen on 8/16/15.
//  Copyright (c) 2015 Kevin Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let defaults          = NSUserDefaults.standardUserDefaults()
    let lastCloseTimeKey  = "lastCloseTimeKey"
    let startBlank        = "startBlank"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
//        println("applicationWillResignActive")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
//        println("applicationDidEnterBackground")
        
        defaults.setObject(NSDate(), forKey: lastCloseTimeKey)
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
//        println("applicationWillEnterForeground")
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
//        println("applicationDidBecomeActive")
        
        if defaults.objectForKey(lastCloseTimeKey) != nil {
            let tenMinutes = 10 * 60
            
            let currentTime = NSDate()
            let lastCloseTime: NSDate = (defaults.objectForKey(lastCloseTimeKey) as! NSDate)
            let intervalMinutes = NSInteger(round(currentTime.timeIntervalSinceDate(lastCloseTime)))
            
//            println("--curr: \(currentTime)")
//            println("--prev: \(lastCloseTime)")
//            println("--interval: \(intervalMinutes)")
            
            if intervalMinutes > tenMinutes {
//                println("clearrrr")
                defaults.setBool(true, forKey: startBlank)
            } else {
//                println("dont clear")
                defaults.setBool(false, forKey: startBlank)
            }
        } else {
            defaults.setBool(true, forKey: startBlank)
        }
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
//        println("applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

