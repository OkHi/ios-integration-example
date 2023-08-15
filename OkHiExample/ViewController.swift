//
//  ViewController.swift
//  OkHiExample
//
//  Created by Julius Kiano on 29/03/2022.
//

import UIKit
import OkHi
import CoreLocation

class ViewController: UIViewController {
    private let okCollect = OkCollect()
    private let okVerify = OkVerify()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        okCollect.delegate = self
        okVerify.delegate = self
    }
    
    @IBAction func onButtonPress(_ sender: UIButton) {
        if okVerify.isLocationServicesEnabled() {
            if okVerify.isBackgroundLocationPermissionGranted() {
                startAddressCreation()
            } else {
                okVerify.requestBackgroundLocationPermission()
            }
        }
    }
    
    func startAddressCreation() {
        let okHiTheme = OkHiTheme().with(logoUrl: "https://cdn.okhi.co/icon.png").with(appBarColor: "#ba0c2f").with(appName: "OkHi")
        let okHiConfig = OkHiConfig().enableStreetView().enableAppBar()
        guard let vc = okCollect.viewController(with: OkHiUser(phoneNumber: "+2348000000000")
            .with(firstName: "Gift")
            .with(lastName: "Moore")
            .with(email: "gift@okhi.com"), okHiTheme: okHiTheme, okHiConfig: okHiConfig) else {
            return
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func startAddressVerification(user: OkHiUser, location: OkHiLocation) {
        okVerify.startAddressVerification(user: user, location: location)
    }
    
}

extension ViewController: OkCollectDelegate {
    func collect(didEncounterError error: OkHiError) {
        // handle error
        debugPrint(error)
    }
    
    func collect(didSelectAddress user: OkHiUser, location: OkHiLocation) {
        startAddressVerification(user: user, location: location)
    }
    
    
}

extension ViewController: OkVerifyDelegate {
    func verify(_ okverify: OkVerify, didChangeLocationPermissionStatus requestType: OkVerifyLocationPermissionRequestType, status: Bool) {
        if requestType == .always && status {
            startAddressCreation()
        }
    }
    
    func verify(_ okverify: OkVerify, didInitialize result: Bool) {
        print("initialized successfully")
    }
    
    func verify(_ okverify: OkVerify, didEncounterError error: OkVerifyError) {
        debugPrint(error)
    }
    
    func verify(_ okverify: OkVerify, didStartAddressVerificationFor locationId: String) {
        print("started verification for: \(locationId)")
    }
    
    func verify(_ okverify: OkVerify, didStopVerificationFor locationId: String) {
        print("stopped verification for: \(locationId)")
    }
    
    func verify(_ okverify: OkVerify, didUpdateLocationPermissionStatus status: CLAuthorizationStatus) {
        // called on each status change
        print("location permission status updated")
    }
    
    func verify(_ okverify: OkVerify, didUpdateNotificationPermissionStatus status: Bool) {
        print("push notification status updated")
    }
}

