//
//  TodayViewController.swift
//  myLocation
//
//  Created by Ram on 3/1/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotifications
import UserNotificationsUI //framework to customize the notification
import Alamofire
import SwiftKeychainWrapper

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var panicButtonView: UIButton!
    @IBOutlet weak var accidentAlertView: UIButton!
    
    let requestIdentifier = "SampleRequest" //identifier is to cancel the notification request
    
    let panicImage = UIImage(named: "GPS_ALERT-01.png")
    let stopImage = UIImage(named: "GPS_ALERT-01-01.png")
    let medicEmergency = UIImage(named: "MEDICAL_ALERT2-01.png")
    var estatusAlarma = 0
    var loopStop: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TodayViewController.Tap))  //Tap function will call when user tap on button
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(TodayViewController.Long)) //Long function will call when user long press on button.
        longGesture.minimumPressDuration = 2.0
        panicButtonView.addGestureRecognizer(longGesture)
        
        tapGesture.numberOfTapsRequired = 1
        panicButtonView.addGestureRecognizer(tapGesture)
        
        
        panicButtonView.setBackgroundImage(panicImage, for: .normal)
        
        let tapGestureMedical = UITapGestureRecognizer(target: self, action: #selector(TodayViewController.TapMedical))  //Tap function will call when user tap on button
        let longGestureMedical = UILongPressGestureRecognizer(target: self, action: #selector(TodayViewController.LongMedical)) //Long function will call when user long press on button.
        longGestureMedical.minimumPressDuration = 2.0
        tapGestureMedical.numberOfTapsRequired = 1
        accidentAlertView.addGestureRecognizer(tapGestureMedical)
        accidentAlertView.addGestureRecognizer(longGestureMedical)
        accidentAlertView.setBackgroundImage(medicEmergency, for: .normal)
    }
    
    func Tap() {
        
        print("Tap happend")
        panicButtonView.layer.removeAllAnimations()
        print("Removed all pending notifications")

        self.loopStop = 1
        panicButtonView.setBackgroundImage(panicImage, for: .normal)
    }
    
    func Long() {
        
        if 0 == 0{
            
            panicButtonView.setBackgroundImage(stopImage, for: .normal)
            
            let pulseAnimation = CABasicAnimation(keyPath: "opacity")
            pulseAnimation.duration = 1
            pulseAnimation.fromValue = 0.5
            pulseAnimation.toValue = 1
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = FLT_MAX
            panicButtonView.layer.add(pulseAnimation, forKey: "animateOpacity")
            
            if loopStop == 0 {
                //Send request to server
                
                let deviceToken = "90807CC9931EA0806FA24A6C551853D236BAED4C28C2E9F3D2A4B2B718ACDDDF"
                let message = "Aqui mandaría Ubicación"
                let url = "URL Field"
                
                let urlString = "http://api.gateguard.com.mx/api/Accounts/notifs"
                
                let parameters: Parameters = [
                    //$deviceToken,$message,$url
                    "deviceToken": deviceToken,
                    "message": message,
                    "url": url
                ]
                
                Alamofire.request(urlString, method: .post, parameters:parameters).responseString {response in
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    
                    print(response.result)
                    
                    
                }

            }
        }
    }
    
    func TapMedical() {
        
        print("Tap happend")
        accidentAlertView.layer.removeAllAnimations()
        print("Removed all pending notifications")
        
        accidentAlertView.setBackgroundImage(medicEmergency, for: .normal)
        
        
    }
    
    func LongMedical() {
        
        
            accidentAlertView.setBackgroundImage(stopImage, for: .normal)
            
            let pulseAnimation = CABasicAnimation(keyPath: "opacity")
            pulseAnimation.duration = 1
            pulseAnimation.fromValue = 0.5
            pulseAnimation.toValue = 1
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = FLT_MAX
            accidentAlertView.layer.add(pulseAnimation, forKey: "animateOpacity")
        
        if loopStop == 0 {
            //Send request to server
            
            let deviceToken = "90807CC9931EA0806FA24A6C551853D236BAED4C28C2E9F3D2A4B2B718ACDDDF"
            let message = "Emergencia Medica"
            let url = "URL Field"
            
            let urlString = "http://api.gateguard.com.mx/api/Accounts/notifs"
            
            let parameters: Parameters = [
                //$deviceToken,$message,$url
                "deviceToken": deviceToken,
                "message": message,
                "url": url
            ]
            
            Alamofire.request(urlString, method: .post, parameters:parameters).responseString {response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
                print(response.result)
                
                
            }
            
        }

        
    }

        func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}


