//
//  FirebaseController.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 1/12/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
// firebaseAuth allows us to use the authentication features of Firebase
import FirebaseAuth
// FirebaseFirestore allows us to use the firestore database functionality
import FirebaseFirestore

class FirebaseController: NSObject, DatabaseProtocol {
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var alertsRef: CollectionReference?
    var alerts: [Alert]
    
    override init() {
        FirebaseApp.configure()
        authController = Auth.auth()
        database = Firestore.firestore()
        alerts = [Alert]()
        
        super.init()
        authController.signInAnonymously() { (authResult, error) in
            guard authResult != nil else {
                fatalError("Firebase authentication failed")
            }
            // if authenticated, attach listener to firebase store
            self.setUpListeners()
        }
    }
    
    func setUpListeners() {
        alertsRef = database.collection("alertCollection")
        // snapshot listener returns a snapshot of the data for the given reference
        // In this case it is the entire collection of sensor readings
        //this query contains all readings and not just the updated ones, we need to filter them out
        //everytime an update is made to the sensor_readings, this method will be called which will call    parseSensorReadingsSnapshot
        
        alertsRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("error fetching documents: \(error!)")
                return
            }
            self.parseSensorReadingsSnapshot(snapshot: querySnapshot!)
        }
    }
    
    func parseSensorReadingsSnapshot(snapshot: QuerySnapshot) {
        snapshot.documentChanges.forEach { change in
            let _ = change.document.documentID
            guard (change.document.data()["alert"] != nil) else {
                return
            }
            let alert = change.document.data()["alert"] as! String
            let date = Date()
            
            if change.type == .added || change.type == .modified {
                let newAlert = Alert(alert: alert, timestamp: date)
                alerts.append(newAlert)
            }
            
            
        }
        
        alerts = alerts.sorted(by: { $0.timestamp < $1.timestamp })
        listeners.invoke { (listener) in
            listener.onAlertListChange(change: .update, alertList: alerts)
        }
    }
    
    func addAlert(alert: String) {
        let _ = alertsRef?.addDocument(data: ["alert" : alert])
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        listener.onAlertListChange(change: .update, alertList: alerts)
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
}
