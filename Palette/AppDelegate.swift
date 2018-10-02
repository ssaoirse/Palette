//
//  AppDelegate.swift
//  Palette
//
//  Created by Saoirse on 9/29/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var colorPaletteInterface: ColorPaletterBusinessLogic? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configure(dependency: AppDependency())
        
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

    func testLoginInteractor() {
        let urlSession = URLSession.shared
        let webServiceProvider = WebServiceProvider(urlSession: urlSession)
        let loginInterface = LoginInteractor(webServiceProvider: webServiceProvider)
        loginInterface.login(with: "fstester", password: "FStst313")
    }
    
    func testColorPaletteInterface() {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1Mzg0NjI1OTUsImp0aSI6IjVkNDM4ZTRiLWJlM2QtNDI0Yy05MWUzLWFkNzhjOWI4NDhlMSIsInN1YiI6ImZzdGVzdGVyIiwiZXhwIjoxNTM4NTQ4OTk1LCJuYmYiOjE1Mzg0NjI1OTV9.YrObPFVl3NyKJBXyeO_CQEuEaY9-BZTQtRef4VBShZs"

        let urlSession = URLSession.shared
        let requestId = 99
        let webServiceProvider = WebServiceProvider(urlSession: urlSession)
        colorPaletteInterface = ColorPaletterInteractor(requestId: requestId,
                                                        authToken: token,
                                                        webServiceInterface: webServiceProvider)
        
        colorPaletteInterface?.fetchBackgroundColor()
        
//        let paletteColor = PaletteColor(id: 1, hexString: "000000")
//        colorPaletteInterface?.saveBackgroundColor(paletteColor)
    }

}

// MARK:- Extension.
extension UIApplicationDelegate {
    func configure(dependency: Dependency) {
        DependencyInjector.dependencies = dependency
    }
}

