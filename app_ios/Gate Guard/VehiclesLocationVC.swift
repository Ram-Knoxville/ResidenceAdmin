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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(vehicleUid)
        
        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        coverView.isHidden = true
        
        locationMap.delegate = self
        
        locationMap.accessibilityNavigationStyle = UIAccessibilityNavigationStyle.combined
        
        let newYorkLocation = CLLocation(latitude: 40.730872, longitude: -74.003066) //
        centerMapOnLocation(location: newYorkLocation)
        // Drop a pin
        let newYorkLocationPin = CLLocationCoordinate2DMake(40.730872, -74.003066)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = newYorkLocationPin
        dropPin.title = " "
        
        locationMap.addAnnotation(dropPin)
        
        // set initial location in last vehicle's location
        //let initialLocation = CLLocation(latitude: 25.666661, longitude: -100.308198)
        //centerMapOnLocation(location: initialLocation)
        
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
                
                for i in dict["data"]!["location"] as! NSDictionary{
                    
                    print(i.value)                }
                
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
            annotationView?.detailCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "customPinVehicles"))
            
        }
        
        if let annotationView = annotationView {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "customPinVehicles")
        }
        return annotationView
    }

}
