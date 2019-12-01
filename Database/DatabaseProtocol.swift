//
//  DatabaseProtocol.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 1/12/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import Foundation

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}

protocol DatabaseListener: AnyObject {
    func onAlertListChange(change: DatabaseChange, alertList: [Alert])
}

protocol DatabaseProtocol: AnyObject {
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
