//
//  AppDelegate.swift
//  InstaCloneParse
//
//  Created by Bertuğ Horoz on 19.11.2022.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration { ParseMutableClientConfiguration in
            ParseMutableClientConfiguration.applicationId = "hv6jEldicl4SFIkIf82pfvgqLTBpazRTavKYi2cL"
            ParseMutableClientConfiguration.clientKey = "cykJUyWeBuUhW5z8oQLIzjgIVu3CMsZxaxhJ9Dvl"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
        }
        
        Parse.initialize(with: configuration)
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        rememberUser()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    //RememberUserFunction
    func rememberUser() {
        let user : String? = UserDefaults.standard.string(forKey: "username")
        if user != nil {
            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = board.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            window?.rootViewController = tabBar
        }
    }

    
}

