//
//  ViewController.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 30/11/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var label: UILabel!
    
    fileprivate var location: CLLocationManager?
    private var time = Date()
    
    private let uuid = UUID(uuidString: "C14ABEEA-B167-4B66-A7FF-3DB2F6AC4D87")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToSpeech("The device is scanning for point of interest. To continue scanning keep the app open")
        location = CLLocationManager()
        location?.delegate = self
        location?.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                }
            }
        }
    }
    
    func startScanning(){
        let beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: 0, minor: 0)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: beaconConstraint, identifier: "MyBeacon")
        location?.startMonitoring(for: beaconRegion)
        location?.startRangingBeacons(satisfying: beaconConstraint)
    }
    
    
    
    func update(distance: CLProximity){
        
            switch distance{
                case .unknown:
                    self.label.text = "unknown"
                self.view.backgroundColor = UIColor.gray
                case .far:
                    self.label.text = "Detected"
                self.view.backgroundColor = UIColor.blue
                    if time.timeIntervalSinceNow < -10 {
                        UIDevice.vibrate()
                        textToSpeech("Now entering Accenture Bank. Continue straight for 3 meters to reach the counter")
                        time = Date()
                    }
                    
                case .near:
                    self.label.text = "Counter"
                    self.view.backgroundColor = UIColor.orange
                    if time.timeIntervalSinceNow < -10 {
                        UIDevice.vibrate()
                        textToSpeech("The counter is on your left")
                        time = Date()
                    }
                    
                case .immediate:
                    self.label.text = "immediate"
                self.view.backgroundColor = UIColor.red
                @unknown default:
                    fatalError()
            }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CLLocationManager.headingAvailable() {
            location?.startUpdatingHeading()
            location?.headingFilter = 90
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        location?.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let currentHeading = newHeading.magneticHeading
        print("\(currentHeading)")
    }

}



