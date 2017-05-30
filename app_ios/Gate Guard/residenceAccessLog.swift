//
//  residenceAccessLog.swift
//  Gate Guard
//
//  Created by Ram on 5/29/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class residenceAccessLog {
 
    private var _accessGranted: String!
    private var _accessType: String!
    private var _card: String!
    private var _date: String!
    private var _dateFull: String!
    private var _doorDirection: String!
    private var _doorEnter: String!
    private var _id: String!
    private var _name: String!
    private var _plate: String!
    private var _time: String!
    private var _type: Int
    private var _uid: String!
    
    var accessGranted : String {
        return _accessGranted
    }
    
    var accessType : String {
        return _accessType
    }
    
    var card : String {
        return _card
    }
    
    var date : String {
        return _date
    }
    
    var dateFull : String {
        return _dateFull
    }
    
    var doorDirection : String {
        return _doorDirection
    }
    
    var doorEnter : String {
        return _doorEnter
    }
    
    var id : String {
        return _id
    }
    
    var name : String {
        return _name
    }
    
    var plate : String {
        return _plate
    }
    
    var time : String {
        return _time
    }
    
    var type : Int {
        return _type
    }
    
    var uid : String {
        return _uid
    }
    
    init(accessGranted : String, accessType : String, card : String, date : String, dateFull : String, doorDirection : String, doorEnter : String, id : String, name : String, plate : String, time : String, type : Int, uid : String) {
        
        self._accessGranted = accessGranted
        self._accessType = accessType
        self._card = card
        self._date = date
        self._dateFull = dateFull
        self._doorDirection = doorDirection
        self._doorEnter = doorEnter
        self._id = id
        self._name = name
        self._plate = plate
        self._time = time
        self._type = type
        self._uid = uid
        
    }
    
}
