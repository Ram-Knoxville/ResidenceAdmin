//
//  LandingVC.swift
//  Gate Guard
//
//  Created by Ram on 2/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import APScheduledLocationManager
import CoreLocation
import LocalAuthentication
import UserNotifications



class LandingVC: UIViewController, APScheduledLocationManagerDelegate, CLLocationManagerDelegate, ProximityContentManagerDelegate {

    var proximityContentManager: ProximityContentManager!
    
    let locationManager = CLLocationManager()
    
    
    

    
    
    
    //let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "EB4081C9-EC31-8326-C6E3-6393BA30539E")!, identifier: "Estimotes")
    
    // Note: make sure you replace the keys here with your own beacons' Minor Values
    let colors = [
        38045: UIColor(red: 84/255, green: 77/255, blue: 160, alpha: 1),
        47262: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        45162: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    
    var pushNotificationState = 0
    
    
    var sleepStatus = 0
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var profileSelected: UILabel!
    
    @IBOutlet weak var SuburbImageView: UIImageView!
    
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound];
    
    var userUid: String!
    var deviceToken: String!
    var sessionToken: String!
    
    var locationData = [String: String]()
    
    var locationDataString: String!
    
    var beaconDetected: Bool!
    
    var beaconStatus = 0
    
    private var manager: APScheduledLocationManager!
    
    var SuburbLogo: String!
    
    var doorToken: String!
    var doorUid: String!
    
    var validator: Bool!
    var validatorValue: Bool! = false
    
    //Beacons variables !
    
    let beaconRegions = [CLBeaconRegion(proximityUUID: NSUUID(uuidString: "EB4081C9-EC31-8326-C6E3-6393BA30539E")! as UUID, identifier: "Lic"), CLBeaconRegion(proximityUUID: NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! as UUID, identifier: "Desarrollo")]
    
    //Ends Beacon Variables !!
    
    override func viewWillAppear(_ animated: Bool) {
        self.askForTouchId()
        if UserDefaults.standard.object(forKey: "ValidadorPermisoEntrada") != nil {
            
            if UserDefaults.standard.bool(forKey: "ValidadorPermisoEntrada") == true {
                validatorValue = true
            }else {
                validatorValue = false
            }
            
        }else {
            validator = false
        }
        
    }
    
    // Starts viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        //BEACONS !!!
        
        
        self.proximityContentManager = ProximityContentManager(
            beaconIDs: [
                BeaconID(UUIDString: "EB4081C9-EC31-8326-C6E3-6393BA30539E", major: 14651, minor: 45162),
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", major: 64782, minor: 47262),
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D", major: 53356, minor: 38045)
            ],
            beaconContentFactory: CachingContentFactory(beaconContentFactory: BeaconDetailsCloudFactory()))
        self.proximityContentManager.delegate = self
        self.proximityContentManager.startContentUpdates()
        
        
        //END BEACONS !!!
        
        manager = APScheduledLocationManager(delegate: self)
        var logo: String! = ""
        // Suburb Logo Config Begins
        if UserDefaults.standard.string(forKey: "ProfileLogo") == nil {
            logo = ""
        }else {
            logo = UserDefaults.standard.string(forKey: "ProfileLogo")!
        }
        
        
        print(logo)
        
        if logo != "" {
            SuburbLogo = UserDefaults.standard.string(forKey: "ProfileLogo")!
        }else {
            SuburbLogo = "gateguard_LOGO-1"
        }

        
        print(SuburbLogo)
        
        if SuburbLogo == "gateguard_LOGO-1" {
            let url = NSURL(string: "http://api.gateguard.com.mx/uploads/suburbs/logos/not_available.png")!
            if let data = NSData(contentsOf: url as URL) {
                self.SuburbImageView.image = UIImage(data: data as Data)
            }

        }else {
            let url = NSURL(string: "http://api.gateguard.com.mx/uploads/suburbs/logos/\(SuburbLogo!)")!
            if let data = NSData(contentsOf: url as URL) {
                self.SuburbImageView.image = UIImage(data: data as Data)
            }

        }
        // Suburb Logo Config Ends
        
        // Geo location Process Begins
        if manager.isRunning {
            
            manager.stoptUpdatingLocation()
            
        }else{
            
            if CLLocationManager.authorizationStatus() == .authorizedAlways {
                
                if KeychainWrapper.standard.double(forKey: "timeInterval") != nil {
                    let intervalValue: Double! = KeychainWrapper.standard.double(forKey: "timeInterval")
                    manager.startUpdatingLocation(interval: intervalValue, acceptableLocationAccuracy: 100)
                    
                }else {
                    
                    manager.startUpdatingLocation(interval: 60, acceptableLocationAccuracy: 100)
                    
                }

            }else{
                
                manager.requestAlwaysAuthorization()
            }
        }
        // Geo location Process Ends

        //Read from memory
        
        let firstName: String! = UserDefaults.standard.string(forKey: "userFirstName")!//KeychainWrapper.standard.string(forKey: "userFirstName")!
        let lastName: String! = UserDefaults.standard.string(forKey: "userLastName")!//KeychainWrapper.standard.string(forKey: "userLastName")!
        let fullName: String! = firstName + " " + lastName
        
        self.profileSelected.text = UserDefaults.standard.string(forKey: "selectedProfile")!//KeychainWrapper.standard.string(forKey: "selectedProfile")!
        
        self.userFullName.text = fullName
        
        self.deviceToken = UserDefaults.standard.string(forKey: "token")!//KeychainWrapper.standard.string(forKey: "token")
        
        if deviceToken == nil
        {
            
            print("Los tokens no se generan en un simulador")
            
        }
        else if deviceToken == ""
        {
            
            print("Los tokens no se generan en un simulador")
            
        }else {
            self.registerToken()
        }

        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        //locationManager.startRangingBeacons(in: region)
        
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        let action = UNNotificationAction(identifier: "remindLater", title: "Abrir", options: [])
        let action2 = UNNotificationAction(identifier: "remindLater2", title: "Ignorar", options: [])
        let category = UNNotificationCategory(identifier: "myCategory", actions: [action, action2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    // Ends ViewDidLoad
    
    //Beacons Region
    
    func proximityContentManager(_ proximityContentManager: ProximityContentManager, didUpdateContent content: AnyObject?) {

        
        
        if let beaconDetails = content as? BeaconDetails {
            self.view.backgroundColor = beaconDetails.backgroundColor
            print("You're in \(beaconDetails.beaconName)'s range!")
            
            
            beaconRegions.forEach(locationManager.startRangingBeacons(in:))
            print("")
            
        } else {
            self.view.backgroundColor = BeaconDetails.neutralColor
            print("No beacons in range.")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        sleepStatus = 0
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        
        print(validatorValue)
        
        
        if validatorValue == true {
            
            let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
            
            
            
            if (knownBeacons.count > 0) {
                let closestBeacon = knownBeacons[0] as CLBeacon
                //self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
                if sleepStatus == 0 {
                    if UIDevice.current.orientation.isLandscape {
                        beaconStatus = 0
                        sleepStatus = 0
                        print("landscape")
                    } else {
                        print("portrait")
                    }
                }else {
                    
                }
                
                

                let beaconsUuid: String! = closestBeacon.proximityUUID.uuidString
                
                
                if closestBeacon.proximity == CLProximity.unknown {
                    
                } else if closestBeacon.proximity == CLProximity.immediate {
                    if beaconStatus == 0 {
                        print("Este es el uid")
                        print(beaconsUuid)
                        print("Termina UUID")
                        
                        if beaconStatus == 0 {
                            beaconDetected = true
                            pushNotificationState = pushNotificationState + 1
                            print("Dato de estado = \(pushNotificationState)")
                            abrePuerta(beaconUid: beaconsUuid)
                            
                            
                            
                            beaconStatus = 1
                            
                            
                        }else {
                            
                        }
                    }else {
                        self.beaconStatus = 0
                        print("beaconStatus es 1")
                    }
                    
                    
                    print("Im immediate")
                
                }else if closestBeacon.proximity == CLProximity.near {
                    
                    sleepStatus = 0
                    print("Im near")
                }
                
            }
            
        }else if validatorValue == false {
            //print("Ain't nobody gave you permission for that hoe!")
        }
        
        beaconRegions.forEach(locationManager.stopRangingBeacons(in:))
        beaconRegions.forEach(locationManager.startRangingBeacons(in:))
        
    }
    
    //Ends beacons region
    
    func askForTouchId(){
//        let authenticationContext = LAContext()
//        var error: NSError?
//        
//        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Para continuar identifiquese por TouchID", reply: { (success: Bool, error: Error?) in
//                
//                if success {
//                    
//                } else {
//                    if let evaluateError = error as NSError? {
//                        let message = self.errorMessageForLAErrorCode(errorCode: evaluateError.code)
//                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
//                    }
//                }
//                
//                
//            })
//        } else {
//            showAlertViewForNoBiometrics()
//            return
//        }

    }
    
    
    func showAlertViewForNoBiometrics() {
        showAlertWithTitle(title: "Error", message: "este dispositivo no cuenta con TouchId Activado el cual es necesario para la seguridad del usuario, porfavor valla a configración y activelo.")
        self.goBackToLogin()
    }
    
    func showAlertWithTitle(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func showAlertViewAfterEvaluatingPolicyWithMessage(message: String) {
        showAlertWithTitle(title: "Error", message: message)
    }
    
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        switch errorCode {
        case LAError.appCancel.rawValue:
            message = "Autenticación cancelada por aplicación"
            self.goBackToLogin()
            
        case LAError.authenticationFailed.rawValue:
            message = "Credenciales invalidas"
            self.goBackToLogin()
            
        case LAError.invalidContext.rawValue:
            message = "Contexto Invalido"
            self.goBackToLogin()
            
        case LAError.passcodeNotSet.rawValue:
            message = "El dispositivo no tiene una huella guardada en sistema"
            self.goBackToLogin()
            
        case LAError.systemCancel.rawValue:
            message = "Autenticación cancelada por sistema"
            self.goBackToLogin()
            
        case LAError.touchIDLockout.rawValue:
            message = "Demaciados intentos aplicados."
            self.goBackToLogin()
            
        case LAError.touchIDNotAvailable.rawValue:
            //message = "Este dispositivo no cuenta con TouchID"
            message = "Usuario Autenticado Correctamente"
            //self.goBackToLogin()
            
        case LAError.userCancel.rawValue:
            message = "Validación cancelada por el usuario"
            self.goBackToLogin()
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            self.goBackToLogin()
            
        default:
            message = "Error No identificado"
            self.goBackToLogin()
        }
        return message
    }
    
    func registerToken() -> Void {
        
        //Send request to server
        let token =             UserDefaults.standard.string(forKey: "token")!
        let userUid =           UserDefaults.standard.string(forKey: "userUid")!
        let accountId =         UserDefaults.standard.string(forKey: "userId")!
        let deviceToken: String!
        let deviceModel =       UserDefaults.standard.string(forKey: "deviceModel")!
        let identification =    UserDefaults.standard.string(forKey: "deviceName")!
        let residenceId =       UserDefaults.standard.string(forKey: "ResidenceUid")!
        let suburbId =          UserDefaults.standard.string(forKey: "SuburbUid")!
        let accessGranted =     "1"
        let lastAccess =        " "
        if UserDefaults.standard.string(forKey: "deviceToken") == nil {
            return
        }else {
            deviceToken =       UserDefaults.standard.string(forKey: "deviceToken")!
        }
        
        print("Token: \(token)")
        print("userUid: \(userUid)")
        print("AccountId: \(accountId)")
        print("deviceToken: \(deviceToken)")
        print("deviceModel: \(deviceModel)")
        print("Identification: \(identification)")
        print("residenceId: \(residenceId)")
        print("suburbId: \(suburbId)")
        print("AccessGranted by default is: \(accessGranted)")
        print("lastAccess is by default empty: \(lastAccess)")
        
        let urlString = "http://api.gateguard.com.mx/api/Accounts/saveToken"
        
        let parameters: Parameters = [
            "token": token,
            "userUid": userUid,
            "accountId": "1",
            "deviceToken": deviceToken,
            "deviceModel": deviceModel,
            "identification": identification,
            "residenceId":residenceId,
            "suburbId": suburbId,
            "accessGranted": accessGranted,
            "lastAccess": lastAccess
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseString { response in
            
            if let JSON = response.result.value {
                print("Mensaje de tokens:  \(JSON)")
            }
            
            let result = response.result
            
            print(result)
            
        }
        
    }
    
    func goBackToLogin() {
        self.performSegue(withIdentifier: "logOutBtn", sender: nil)
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "profile")
        UserDefaults.standard.removeObject(forKey: "token")

    }

    @IBAction func logOutBtnPressed(_ sender: Any) {
        // Alert
        let refreshAlert = UIAlertController(title: "Alerta", message: "¿Seguro desea Cerrrar Sesión?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.goBackToLogin()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        
        
        present(refreshAlert, animated: true, completion: nil)
    }

    func scheduledLocationManager(_ manager: APScheduledLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        
        let l = locations.first!
        
        
        print("Check this out: \r \(formatter.string(from: Date())) loc: \(l.coordinate.latitude), \(l.coordinate.longitude)")
        
        let userUid = UserDefaults.standard.string(forKey: "userUid")!
        let latitude = l.coordinate.latitude
        let longitude = l.coordinate.longitude
        
        let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
        print(location)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
        
            
            if error != nil {
                print("Reverse geocoder failed with error")
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm: CLPlacemark! = placemarks?[0]
                
                let city: String! = pm.locality!
                let block: String! = pm.subLocality!
                let number: String! = pm.subThoroughfare!
                let street: String! = pm.name!
                let zipCode: String! = pm.postalCode!
                
                self.locationDataString = city + "," + block + "," + number + "," + street + "," + zipCode
                
                
                print("Se supone que aqui ya debe estar listo :")
                print(self.locationDataString)
                
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        let urlString = "http://api.gateguard.com.mx/api/gps/savePosition"
        
        let parameters: Parameters = [
            "address": self.locationDataString,
            "userUid": userUid,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("Mensaje de tokens:  \(JSON)")
            }
            
            
        }
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didFailWithError error: Error) {
        
    }
    
    internal func scheduledLocationManager(_ manager: APScheduledLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    func abrePuerta(beaconUid: String) {
        if sleepStatus == 0 {
            if beaconStatus == 0 {
                //Send request to server
                let accountUid: String! = UserDefaults.standard.string(forKey: "userUid")!
                //            let beaconUid: String! = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
                
                let urlString = "http://api.gateguard.com.mx/api/doors/getDoorsBeacon"
                
                let parameters: Parameters = [
                    "accountUid": accountUid,
                    "beaconUid": beaconUid
                ]
                
                Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                    
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                    
                    let result = response.result
                    
                    var doorDirectionId: String!
                    var doorTypeId: String!
                    var doorName: String!
                    var isPedestrian: String!
                    
                    
                    if let dict = result.value as? Dictionary<String, AnyObject>{
                        
                        print("Aqui empieza el diccionario \(dict)")
                        if dict["data"]!["status"] as! Int == 1 {
                            
                            for i in dict["data"]!["dato"] as! NSDictionary{
                                
                                if i.key as! String == "token" {
                                    self.doorToken = i.value as! String
                                }else if i.key as! String == "doorDirectionId" {
                                    doorDirectionId = i.value as! String
                                }else if i.key as! String == "doorTypeId" {
                                    doorTypeId = i.value as! String
                                }else if i.key as! String == "name" {
                                    doorName = i.value as! String
                                }else if i.key as! String == "pedestrian" {
                                    isPedestrian = i.value as! String
                                }else if i.key as! String == "uid" {
                                    self.doorUid = i.value as! String
                                }
                            }
                            
                            print("Inicio de valores capturados")
                            print(self.doorToken)
                            print(doorDirectionId)
                            print(doorTypeId)
                            print(doorName)
                            print(isPedestrian)
                            print(self.doorUid)
                            print("Final de valores capturados")
                            
                            if self.doorToken != nil, self.doorUid != nil {
                                let state: UIApplicationState = UIApplication.shared.applicationState
                                
                                
                                if (state == .background || state == .inactive) {
                                    
                                    if self.sleepStatus == 0 {
                                        
                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
                                        
                                        let content = UNMutableNotificationContent()
                                        content.title = "Punto de Acceso Detectado"
                                        content.body = "¿Desea Abrir \(doorName!)?"
                                        content.sound = UNNotificationSound.default()
                                        content.categoryIdentifier = "myCategory"
                                        
                                        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
                                        
                                        self.beaconStatus = 1
                                        
                                        UNUserNotificationCenter.current().delegate = self
                                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                        UNUserNotificationCenter.current().add(request) {(error) in
                                            if let error = error {
                                                print("Uh oh! We had an error: \(error)")
                                            }
                                        }
                                        self.sleepStatus = 1
                                    }else {
                                        print("Estoy dormido alv")
                                    }
                                    
                                    
                                    
                                }else if state == .active {
                                    print(self.beaconStatus)
                                    if self.beaconStatus == 0 {
                                        self.beaconStatus = 1
                                        let refreshAlert = UIAlertController(title: "Alerta", message: "¿Desea Abrir \(doorName!)?", preferredStyle: UIAlertControllerStyle.alert)
                                        
                                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                            print("Handle Ok logic here")
                                            
                                            let urlString = "http://api.gateguard.com.mx/api//doors/openDoorsBeacon"
                                            
                                            let parameters: Parameters = [
                                                "token": self.doorToken,
                                                "doorUid": self.doorUid
                                            ]
                                            
                                            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                                                
                                                
                                                
                                                if let JSON = response.result.value {
                                                    print("JSON: \(JSON)")
                                                }
                                            }
                                            
                                            
                                        }))
                                        
                                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                                            print("Handle Cancel Logic here")
                                            self.beaconStatus = 1
                                        }))
                                        
                                        self.present(refreshAlert, animated: true, completion: nil)
                                        
                                        self.beaconStatus = 1
                                        
                                    }else {
                                        print("BeaconStatus = 1")
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                    self.beaconStatus = 1
                    
                }
                
                
            }else if beaconStatus == 1 {
                print("BeaconStatus es 1")
            }
        }else {
            print("Soy un mensaje raro")
        }
        
    }
}

extension LandingVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "remindLater" {
            
            print("Hola Mundo")
            let urlString = "http://api.gateguard.com.mx/api//doors/openDoorsBeacon"
            
            let parameters: Parameters = [
                "token": self.doorToken,
                "doorUid": self.doorUid
            ]
            Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
                
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
            
            
        }
        
        
    }
}
