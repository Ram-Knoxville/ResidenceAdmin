//
//  AlarmPanels.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class AlarmPanels {
    private var _date: String!
    private var _time: String!
    private var _type: String!
    private var _alarmClass: String!
    private var _event: String!
    private var _status: String!
    
    var date: String {
        return _date
    }
    
    var time: String {
        return _time
    }
    
    var type: String {
        return _type
    }
    
    var alarmClass: String {
        return _alarmClass
    }
    
    var event: String {
        return _event
    }
    
    var status: String {
        return _status
    }
    
    init(date: String, time: String, type: String, alarmClass: String, event: String, status: String){
        self._date = date
        self._time = time
        self._type = type
        self._alarmClass = alarmClass
        self._event = event
        self._status = status
    }
}
