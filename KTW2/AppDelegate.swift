//
//  AppDelegate.swift
//  KTW2
//
//  Created by Gabriel Kieruzel on 1/19/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainTabVC = UITabBarController()
        
//        let _ : UIViewController =
//        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapVC")
        let seeTabVC : TableVC =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainTableVC") as! TableVC
        
        let hotTabVC : TableVC =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hotTableVC") as! TableVC
        
        let eatTabVC : TableVC =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eatTableVC") as! TableVC
        
        let drinkTabVC : TableVC =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "drinkTableVC") as! TableVC
        
        let transTabVC : TableVC =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "transTableVC") as! TableVC
        
        TABSVC.append(seeTabVC)
        TABSVC.append(hotTabVC)
        TABSVC.append(eatTabVC)
        TABSVC.append(drinkTabVC)
        TABSVC.append(transTabVC)
        
        (TABSVC[0] ).tabBarItem =
    UITabBarItem(title: "See", image: UIImage(named: SEE), selectedImage: UIImage(named: SEE))
        
        (TABSVC[1] ).tabBarItem =
    UITabBarItem(title: "Hotels", image: UIImage(named: HOTEL), selectedImage: UIImage(named: HOTEL))
        
        (TABSVC[2] ).tabBarItem =
    UITabBarItem(title: "Eating", image: UIImage(named: EAT ), selectedImage: UIImage(named: EAT ))
        
         (TABSVC[3] ).tabBarItem =
    UITabBarItem(title: "Pubs", image: UIImage(named: DRINK), selectedImage:UIImage(named: DRINK) )
        
        (TABSVC[4] ).tabBarItem =
            UITabBarItem(title: "Transport", image: UIImage(named: TRANSPORT), selectedImage: UIImage(named: TRANSPORT))
       
        //?.withRenderingMode(.alwaysOriginal)
        
//        (TABSVC[0] as UITableViewController).tabBarItem.badgeColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        
        
        mainTabVC.viewControllers = TABSVC as [UITableViewController]
        mainTabVC.viewControllers = TABSVC.map {
            UINavigationController(rootViewController: $0)
        }
        
       self.window?.rootViewController = mainTabVC
//        self.window?.rootViewController = mapsVC
        
        mainTabVC.tabBar.barTintColor = TColors[0]
        UINavigationBar.appearance().barTintColor = TColors[0]
        let attr = [
            NSAttributedStringKey.foregroundColor: UIColor.red
            
        ]
      UINavigationBar.appearance().titleTextAttributes = attr
        mainTabVC.navigationController?.navigationBar.tintColor = UIColor.white
        

        MANTBHGHT = mainTabVC.tabBar.frame.size.height
        
        
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


}

