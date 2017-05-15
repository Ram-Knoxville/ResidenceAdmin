//
//  VehiclesLocationVC.swift
//  Gate Guard
//
//  Created by Ram on 5/15/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import MapKit

class VehiclesLocationVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var coverView: UIView!
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coverView.isHidden = true
        
        locationMap.delegate = self
        locationMap.showsUserLocation = true

        
        // set initial location in last vehicle's location
        let initialLocation = CLLocation(latitude: 25.666661, longitude: -100.308198)
        centerMapOnLocation(location: initialLocation)
        
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        locationMap.setRegion(coordinateRegion, animated: true)
    }

}
