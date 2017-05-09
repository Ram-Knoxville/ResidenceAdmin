//
//  VideoServers.swift
//  Gate Guard
//
//  Created by Ram on 3/9/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation

class VideoServers {
    private var _localIp:        String!
    private var _gateGuardIp:    String!
    
    var localIp: String {
        return _localIp
    }
    
    var gateGuardIp: String {
        return _gateGuardIp
    }
    
    init(localIp: String, gateGuardIp:String){
        self._localIp       = localIp
        self._gateGuardIp   = gateGuardIp
    }
}
