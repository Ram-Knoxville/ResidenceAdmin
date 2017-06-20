//
//  AccessRequest.swift
//  Gate Guard
//
//  Created by Ram on 6/15/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class AccessRequest {
    
    private var _access: String!
    private var _address: String!
    private var _contextImg: String!
    private var _date: String!
    private var _driver: String!
    private var _plateImg: String!
    private var _time: String!
    private var _uid: String!
    private var _wait: String!
    
    var access: String {
        return _access
    }
    
    var address: String {
        return _address
    }
    
    var contextImg: String {
        return _contextImg
    }
    
    var date: String {
        return _date
    }
    
    var driver: String {
        return _driver
    }
    
    var plateImg: String {
        return _plateImg
    }
    
    var time: String {
        return _time
    }
    
    var uid: String {
        return _uid
    }
    
    var wait: String {
        return _wait
    }
    
    init(access: String, address: String, contextImg: String, date:String, driver:String, plateImg:String, time:String, uid:String, wait:String) {
        self._access = access
        self._address = address
        self._contextImg = contextImg
        self._date = date
        self._driver = driver
        self._plateImg = plateImg
        self._time = time
        self._uid = uid
        self._wait = wait
    }
    
}
