//
//  AppDelegate.swift
//  OkHiExample
//
//  Created by Julius Kiano on 29/03/2022.
//

import UIKit
import OkHi

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let okHiAppContext = OkHiAppContext().withAppMeta(name: "OkHi Example", version: "1.0.0", build: "1")
        let okHiAuth = OkHiAuth(
            branchId: "<my_branch_id>",
            clientKey: "<my_client_key>",
            environment: Environment.sandbox, // make sure to change this to prod when you're ready to go live 🚀
            appContext: okHiAppContext
        )
        OkCollect.initialize(with: okHiAuth)
        OkVerify.initialize(with: okHiAuth, launchOptions: launchOptions)
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
    
    
}

