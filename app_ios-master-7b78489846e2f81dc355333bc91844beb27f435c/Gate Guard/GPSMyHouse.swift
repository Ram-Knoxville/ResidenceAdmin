//
//  GPSMyHouse.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class GPSMyHouse {
    private var _name:      String!
    private var _location:  String!
    private var _date:      String!
    
    var name: String {
        return _name
    }
    
    var location: String {
        return _location
    }
    
    var date: String {
        return _date
    }
    
    init(name: String, location: String, date: String){
        self._name      = name
        self._location  = location
        self._date      = date
    }
}
