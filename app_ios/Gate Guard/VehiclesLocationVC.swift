//
//  VehiclesLocationVC.swift
//  Gate Guard
//
//  Created by Ram on 5/15/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class VehiclesLocationVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let regionRadius: CLLocationDistance = 1000
    
    
    var vehicleUid: String!
    
    var serverTime: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(vehicleUid)
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        coverView.isHidden = true
        
        locationMap.delegate = self
        
        locationMap.accessibilityNavigationStyle = UIAccessibilityNavigationStyle.combined
        
        self.askForInfo()
        
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        locationMap.setRegion(coordinateRegion, animated: true)
    }
    // http://localhost/api/api/gps/getLocationVehiclesMobile
    
    func askForInfo(){
        let urlString = "http://api.gateguard.com.mx/api/gps/getLocationVehiclesMobile"
        
        let SuburbUid: String! = UserDefaults.standard.string(forKey: "SuburbUid")
        
        let residenceUid: String! = UserDefaults.standard.string(forKey: "ResidenceUid")
        
        let token: String! = UserDefaults.standard.string(forKey: "token")
        
        let uidFromVehicle: String! = vehicleUid
        
        
        let parameters: Parameters = [
            "suburbUid": SuburbUid,
            "residenceUid": residenceUid,
            "token": token,
            "uid": uidFromVehicle
        ]
        
        Alamofire.request(urlString, method: .post, parameters:parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                var latitude: String!
                var longitude: String!
                
                
                for i in dict["data"]!["location"] as! [[String:Any]]{
                    latitude = i["latitude"] as! String
                    longitude = i["longitude"] as! String
                    self.serverTime = i["servertime"] as! String
                }
                //let newYorkLocation = CLLocation(latitude: 40.730872, longitude: -74.003066)
                //let newYorkLocationPin = CLLocationCoordinate2DMake(40.730872, -74.003066)
                let vehicleLocationPin = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
                let vehicleLocation = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
                self.centerMapOnLocation(location: vehicleLocation)
                
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = vehicleLocationPin
                dropPin.title = " "
                
                self.locationMap.addAnnotation(dropPin)
                
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .system)
            //annotationView?.detailCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "customPinVehicles"))
            
            
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "customPinVehicles")
        }
        return annotationView
    }

}
