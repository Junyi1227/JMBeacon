# JMBeacon
做了一個Beacon Demo
第一次做 趁機研究了一下
參考網路上的文章寫了這篇文

#本文開始

## 硬體
Beacon 的概念其實很簡單，就是一個定時發射固定訊息的藍牙發射器罷了。用beacon做的任何應用邏輯必須在app端實踐。一般beacon的偵測極限是100公尺，但可藉由硬體自行調整訊號強度的方式調整偵測範圍。

可以偵測到beacon的iOS裝置有：iPhone 4S，iPad 3，iPad mini，iPod Touch 5，以及這些裝置的後代。

##入門兩三事

1. 引用 Frameworks，iBeacon 需要  CoreBluetooth 與 CoreLocation 兩個 Franeworks
記得import 
import CoreLocation
import CoreBluetooth

2.建立 CLLocationManaer
```
let locationManager = CLLocationManager()
locationManager.delegate = self

if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways) {
    locationManager.requestAlwaysAuthorization()
}

```
iOS8之後  info.plist 要加   NSLocationWhenAlwaysUsageDescription

3.建立CLBeaconRegion

```
let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")! as UUID, major: 40876, identifier: "JWTestBeacon")
//啟動偵測Beacon
locationManager.startRangingBeacons(in: region)
locationManager.startMonitoring(for: region)
```
建立CLBeaconRegion的參數看下面

4.CLBeaconRegion Delegate
```
//範圍內的Beaacons
func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if (beacons.count > 0) {
        let beacon = beacons[0] as CLBeacon //只取最近的Beacon

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

//進入beacon區域
func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
}

//離開beacon區域
func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
}
```
到這邊應該就可以順利取得資料囉
然後只要看App的需求調整就可以了
log如下
```
UUID == %@ E2C56DB5-DFFB-48D2-B060-D0F5A71096E0
beacon.major == %@ 40876
beacon.minor == %@ 16804
beacon.accuracy == %@ 0.892296942450984
beacon.proximity == %@ CLProximity
beacon.proximity == Near
```
## 參數
UUID：一般用來區分不同的 app 系統或不同的公司。如果家樂福用iBeacon，所有家樂福的beacon會有相同的 UUID，好市多的beacon則廣播另外的UUID。

Major number：UUID之下的辨別碼，通常用來辨識同一地理區域的一群beacon，比如說同一個賣場裡的beacon都有相同的major number。

Minor number：再更細部的辨別碼，通常用來辨識個別的beacon，比如果買場內蔬果區的某個beacon。

TX power：用來判斷使用者與beacon之間的距離遠近。因為是用訊號強度來做判別，所以容易受到傢俱，人群或是其他無限裝置干擾，所以不保證測量數據的精準程度。

本文在此：
http://junyi1227-blog.logdown.com/posts/775259-beacon-swift-3-0
