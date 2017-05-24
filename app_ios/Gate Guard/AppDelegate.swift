//
//  AppDelegate.swift
//  Gate Guard
//
//  Created by Ram on 2/23/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Alamofire
import SwiftKeychainWrapper
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    let requestIdentifier = "Aplicacion Cerrada"
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    let defaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ESTConfig.setupAppID("proximity-content-for-mult-hbb", andAppToken: "f774239a2b7bf7c84a367b0651e27f78")
        
        // Override point for customization after application launch.
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        application.registerForRemoteNotifications()
        
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        
        
        ///////////////////////////////////////////////////////////
        
        let deviceModel = UIDevice.current.model
        print("This is the device model \(deviceModel)")
        let deviceName = UIDevice.current.name
        print("This is the devices name : \(deviceName)")
        
        defaults.set(deviceModel, forKey: "deviceModel")
        defaults.set(deviceName, forKey: "deviceName")
//        KeychainWrapper.standard.set(deviceModel, forKey: "deviceModel")
        
//        KeychainWrapper.standard.set(deviceName, forKey: "deviceName")
        
        
        if UserDefaults.standard.string(forKey: "username") != nil, UserDefaults.standard.string(forKey: "password") != nil {

            let username = UserDefaults.standard.string(forKey: "username")!//KeychainWrapper.standard.string(forKey: "username")!
            let password = UserDefaults.standard.string(forKey: "password")!//KeychainWrapper.standard.string(forKey: "password")!
            self.autoLoginOne(username: username, password: password)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let viewController: LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC;
            // Then push that view controller onto the navigation stack
            let rootViewController = self.window!.rootViewController as! LoginVC;
            rootViewController.show(viewController, sender: self)
        }
        
        return true
    }
    
    func autoLoginOne(username: String, password: String){
        //Send request to server
        print(username)
        print(password)
        print("Checa we")
        
        let urlString = "http://api.gateguard.com.mx/api/Accounts/login"
        
        let parameters: Parameters = [
            "email": username,
            "password": password
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                
                
                if dict["status"] as? String != "OK" {
                    
                    UserDefaults.standard.removeObject(forKey: "username")
                    UserDefaults.standard.removeObject(forKey: "password")
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    UserDefaults.standard.removeObject(forKey: "profile")
                    UserDefaults.standard.removeObject(forKey: "token")
                    
                    // Access the storyboard and fetch an instance of the view controller
                    let storyboard = UIStoryboard(name: "Main", bundle: nil);
                    let viewController: LoginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC;
                    
                    // Then push that view controller onto the navigation stack
                    let rootViewController = self.window!.rootViewController as! UIViewController;
                    //                    rootViewController.pushViewController(viewController, animated: true);
                    rootViewController.show(viewController, sender: self)
                    
                }else if dict["status"] as? String == "OK"{
                    
                    var token: String!
                    for i in dict["data"]!["session"] as! NSDictionary{
                        
                        if i.key as! String == "token" {
                            token = i.value as! String
                        }
                        
                    }
                    let userToken: String! = token
                    self.defaults.set(userToken, forKey: "token")
//                    KeychainWrapper.standard.set(userToken, forKey: "token")
                    
                    
                    if UserDefaults.standard.string(forKey: "profile") != nil {
                        let profileCredential = UserDefaults.standard.string(forKey: "profile")!//KeychainWrapper.standard.string(forKey: "profile")!
                        let userToken: String! = userToken
                        self.autoLogin2(token: userToken, profileSelected: profileCredential)
                        
                    }else {
                        // TODO: Go to BlockSelectorVC
                        print("Go to BlockSelectorVC")
                    }
                }
                
                
            }
        }

    }
    
    func autoLogin2(token: String, profileSelected: String){
        let urlString = "http://api.gateguard.com.mx/api/Accounts/login2"
        print(token)
        print(profileSelected)
        print("checa we")
        
        let parameters: Parameters = [
            "profile": profileSelected,
            "token": token
        ]
        
        
        // TODO refactorizar este código muy cabron
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                print("Aqui empieza el diccionario principal\(dict)")
                
                if dict["status"] as? String != "OK"{

                    
                }else if dict["status"] as? String  == "OK"{
                    
                    // Access the storyboard and fetch an instance of the view controller
                    let storyboard = UIStoryboard(name: "Main", bundle: nil);
                    let viewController: SWRevealViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController;
                    
                    // Then push that view controller onto the navigation stack
                    let rootViewController = self.window!.rootViewController as! UIViewController;
//                    rootViewController.pushViewController(viewController, animated: true);
                    rootViewController.show(viewController, sender: self)

                }
                
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.beginBackgroundTask {
            print("Estoy en Background")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Show notification to keep background
        content.title = "Alerta"
        content.body = "Necesitas tener la aplicación en background para poder acceder a sus funciones."
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let requestidentifier = "myNotification"
        let request = UNNotificationRequest(identifier: requestidentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            // handle error if there is one
            if((error) != nil){
                print("Error completing notification scheduling: \(error!)")
            }else{
                print("Added Notification request successfully with \(self.content.badge!) badges")
            }
            
        })
        // application setApplicationIconBadgeNumber:1
        UIApplication.shared.applicationIconBadgeNumber = 1
        
        print("La app se termino")
        
    }
    
    func validateAccess(deviceToken: String)
    {
        //Send request to server
        
        print(deviceToken)
        
        let urlString = "http://api.gateguard.com.mx/api/Accounts/validateTokenAccess"
        
        let parameters: Parameters = [
            "deviceToken": deviceToken
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result
            print(result)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{

                if dict["status"] as? String != "OK" {
                    
                }else if dict["status"] as? String == "OK"{
                    if dict["message"] as! String == "0"{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil);
                        let viewController: noAccessVC = storyboard.instantiateViewController(withIdentifier: "noAccessVC") as! noAccessVC;
                        
                        // Then push that view controller onto the navigation stack
                        let rootViewController = self.window!.rootViewController as! LoginVC;
                        //            rootViewController.pushViewController(viewController, animated: true);
                        rootViewController.show(viewController, sender: self)
                    }else if dict["message"] as! String == "1"{
                        
                    }
                }
            }
            
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("Este es el token we !!! \(deviceTokenString)")
        
        let deviceToken2: String = deviceTokenString as String!
            defaults.set(deviceToken2, forKey: "deviceToken")
//            KeychainWrapper.standard.set(deviceToken2, forKey: "deviceToken")
        
        self.validateAccess(deviceToken: deviceToken2)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Error: \n \(error) \n")
        
    }
    
    func authAccess(id: String){
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print(userInfo)
        
        var idToAuth: String!

        for i in userInfo["aps"] as! Dictionary<String, Any>{
            
            print("Esta es la llave:  \(i.key)")
            print("Este es el valor: \(i.value)")
            if i.key == "link_url" {
                if i.value as? Int == 23 {
                    idToAuth = String(describing:i.value)
                    
                    self.defaults.set(idToAuth, forKey: "idToAuth")
//                    KeychainWrapper.standard.set(idToAuth, forKey: "idToAuth")
                    
                    
                    print("checate este mugrero : \(idToAuth)")
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let otherVC = sb.instantiateViewController(withIdentifier: "permisoDeAccesos") as! permisoDeAccesos
                    window?.rootViewController = otherVC;
                }else if i.value as! String == "Pluma Detectada" {
                    //goHomeFromGateOpen
                    idToAuth = String(describing:i.value)
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let newVC = sb.instantiateViewController(withIdentifier: "OpenGateVC") as! OpenGateVC
                    window?.rootViewController = newVC;
                }
                
            }
            
        }
        
    }

}
