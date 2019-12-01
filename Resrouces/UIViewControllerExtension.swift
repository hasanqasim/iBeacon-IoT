//
//  UIViewControllerExtension.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 1/12/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension UIViewController{
    func textToSpeech(_ text: String){
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.4
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
}
