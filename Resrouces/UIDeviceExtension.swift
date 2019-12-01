//
//  UIDeviceExtension.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 1/12/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UIDevice{
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
