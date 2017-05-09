//
//  AutomationDevices.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class AutomationDevices {
    //Device UID
    private var _logicAddress:  String!
    //
    private var _name:          String!
    private var _location:      String!
    
    //Device UID
    var logicAddress: String {
        return _logicAddress
    }
    //
    
    var name: String {
        return _name
    }
    
    var location: String {
        return _location
    }
    
    init(logicAddress: String, name: String, location: String){
        //Device UID
        self._logicAddress  = logicAddress
        //
        self._name          = name
        self._location      = location
    }
}
