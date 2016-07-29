//
//  ViewController.swift
//  beacone
//
//  Created by mac on 2016/7/28.
//  Copyright © 2016年 com.idealstemer. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
class ViewController: UIViewController,CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")! as UUID, major: 40876, identifier: "JMTestBeacon")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self

        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }

        //啟動偵測Beacon
        locationManager.startRangingBeacons(in: region)
        locationManager.startMonitoring(for: region)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //範圍內的Beaacons
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//        let knowBeacons = beacons.filter{$0.proximity != CLProximity.unknown}
        if (beacons.count > 0) {
            let beacon = beacons[0] as CLBeacon

            print("UUID == %@",beacon.proximityUUID.uuidString)
            print("beacon.major == %@",beacon.major)
            print("beacon.minor == %@",beacon.minor)
            print("beacon.accuracy == %@",beacon.accuracy)
            print("beacon.proximity == %@",beacon.proximity)

            if (beacon.proximity == .unknown) {
                print("beacon.proximity == Unknown Proximity")
            } else if (beacon.proximity == .immediate) {
                print("beacon.proximity == Immediate")
            } else if (beacon.proximity == .near) {
                print("beacon.proximity == Near")
            } else if (beacon.proximity == .far) {
                print("beacon.proximity == Far")
            }
        }
    }
    //MARK:進入beacon區域
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //
    }

    //離開beacon區域
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //
    }


}

