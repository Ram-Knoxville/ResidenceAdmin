//
//  Events.swift
//  Gamalog
//
//  Created by Ram on 6/5/17.
//  Copyright © 2017 Rowan Technologies. All rights reserved.
//

import Foundation

class Events {
    public var _eventImage: String!
    public var _eventName: String!
    public var _eventDate: String!
    
    var eventName: String! {
        return _eventName
    }
    
    var eventImage: String! {
        return _eventImage
    }
    
    var eventDate: String! {
        return _eventDate
    }
    
    init(eventImage: String, eventName: String, eventDate: String) {
        self._eventImage = eventImage
        self._eventName = eventName
        self._eventDate = eventDate
    }
}
