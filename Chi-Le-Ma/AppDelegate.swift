//
//  AppDelegate.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/29/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
  {
    UINavigationBar.appearance().barTintColor = UIColor(red: 242.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    
    if let barFont = UIFont(name: "Avenir-Light", size: 24.0)
    {
      UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: barFont]
    }
    
    // Change the status bar's appearance
    UIApplication.sharedApplication().statusBarStyle = .LightContent
    
    return true
  }

}