//
//  AlarmEvents.swift
//  Gate Guard
//
//  Created by Ram on 4/17/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class AlarmEvents {
    private var _ack: String!
    private var _date: String!
    private var _eventClass: String!
    private var _eventColor: String!
    private var _eventName: String!
    private var _eventNumber: String!
    private var _time: String!
    private var _toReport: String!
    private var _type: String!
    private var _uid: String!
    
    var ack: String {
        return _ack
    }
    
    var date: String {
        return _date
    }
    
    var eventClass: String {
        return _eventClass
    }
    
    var eventColor: String {
        return _eventColor
    }
    
    var eventName: String {
        return _eventName
    }
    
    var eventNumber: String {
        return _eventNumber
    }
    
    var time: String {
        return _time
    }
    
    var toReport: String {
        return _toReport
    }
    
    var type: String {
        return _type
    }
    
    var uid: String {
        return _uid
    }
    
    init(ack: String, date: String, eventClass: String, eventColor: String, eventName: String, eventNumber: String, time: String, toReport: String, type: String, uid: String) {
        self._ack = ack
        self._date = date
        self._eventClass = eventClass
        self._eventColor = eventColor
        self._eventName = eventName
        self._eventNumber = eventNumber
        self._time = time
        self._toReport = toReport
        self._type = type
        self._uid = uid
    }
}
