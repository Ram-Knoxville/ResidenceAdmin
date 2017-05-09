//
//  LocationManagerVC.swift
//  Gate Guard
//
//  Created by Ram on 4/6/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import MapKit
import APScheduledLocationManager
import CoreLocation


class LocationManagerVC: UIViewController, CLLocationManagerDelegate, APScheduledLocationManagerDelegate {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var myMap: MKMapView!
    private var manager: APScheduledLocationManager!
    
    let manager1 = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        manager1.delegate = self
        manager1.desiredAccuracy = kCLLocationAccuracyBest
        manager1.requestWhenInUseAuthorization()
        manager1.startUpdatingLocation()
        
        manager = APScheduledLocationManager(delegate: self)
        
        if manager.isRunning {
            
            
            manager.stoptUpdatingLocation()
            
        }else{
            
            if CLLocationManager.authorizationStatus() == .authorizedAlways {
                
             
                manager.startUpdatingLocation(interval: 5, acceptableLocationAccuracy: 100)
                
            }else{
                
                manager.requestAlwaysAuthorization()
            }
        }
        
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        self.myMap.setRegion(region, animated: true)
        
        self.myMap.showsUserLocation = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        let l = locations.first!
        
        print("Check this out: \r \(formatter) loc: \(l.coordinate.latitude), \(l.coordinate.longitude)")
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didFailWithError error: Error) {
        
    }
    
    func scheduledLocationManager(_ manager: APScheduledLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}
