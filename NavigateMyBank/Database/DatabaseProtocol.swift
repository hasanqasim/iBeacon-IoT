//
//  DatabaseProtocol.swift
//  NavigateMyBank
//
//  Created by Hasan Qasim on 1/12/19.
//  Copyright © 2019 Hasan Qasim. All rights reserved.
//

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
