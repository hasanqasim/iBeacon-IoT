//
//  LoginViewController.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 30/11/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import UIKit
import LocalAuthentication
import AVFoundation

class LoginViewController: UIViewController {

    @IBAction func loginButton(_ sender: Any) {
        authenticateUsingTouchID()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textToSpeech("Welcome to Nav My Bank. Click on the center of the screen to login")
    }
    
    fileprivate func authenticateUsingTouchID(){
        UIDevice.vibrate()
        textToSpeech("Place your finger on the home button to login")
        
        let authContext = LAContext()
        let authReason = "Using fingerprint to log in"
        var authError: NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason) { (success, error) in
                if success{
                    print("Logged in")
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "Home")
                        self.present(vc, animated: true)
                    }
                } else {
                    if let error = error {
                        self.reportTouchIDError(error: error)
                    }
                }
            }
        } else {
            print(authError!.localizedDescription)
        }
    }
    
    fileprivate func reportTouchIDError(error: Error){
       /* switch error.code{
            case LAError.authenticationFailed.rawValue:
            print("Authentication failed")
            case LAError.passcodeNotSet.rawValue:
            print("Password not set")
            case LAError.systemCancel.rawValue:
            print("authentication was cancelled by system")
            case LAError.userCancel.rawValue:
            print("user cancel auth")
            default:
                print(error.localizedDescription)
        }*/
        print("Error")
    }
    
}
