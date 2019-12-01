//
//  Alert.swift
//  NavigateMyBank
//
//  Created by Hasan Qasim on 1/12/19.
//  Copyright © 2019 Hasan Qasim. All rights reserved.
//

import UIKit

class Alert: NSObject {
    var alert: String
    var timestamp: Date
    
    init(alert: String, timestamp: Date) {
        self.alert = alert
        self.timestamp = timestamp
    }

}
