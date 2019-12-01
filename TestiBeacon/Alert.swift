//
//  Alert.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 1/12/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import Foundation

class Alert: NSObject {
    var alert: String
    var timestamp: Date
    
    init(alert: String, timestamp: Date) {
        self.alert = alert
        self.timestamp = timestamp
    }
    
}
