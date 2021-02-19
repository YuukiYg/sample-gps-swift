//
//  ViewController.swift
//  sample-gps-swift
//
//  Created by YuukiYg on 2021/02/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    // 測位精度
    let locationAccuracy: [Double] = [
        kCLLocationAccuracyBestForNavigation,
        kCLLocationAccuracyBest,
        kCLLocationAccuracyNearestTenMeters,
        kCLLocationAccuracyHundredMeters,
        kCLLocationAccuracyKilometer,
        kCLLocationAccuracyThreeKilometers
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        // 複数行のテキストを表示する
        locationLabel.numberOfLines = 0;
    }
    
    func initLocationManager(){
        // locationManager初期化
        locationManager = CLLocationManager()
        
        // ユーザーの使用許可を確認
        locationManager.requestWhenInUseAuthorization()
        
        // 使用許可に対するステータス
        let status = locationManager.authorizationStatus
        
        if status == .authorizedWhenInUse {
            // delegateを設定
            locationManager.delegate = self
            
            // 測位精度の設定
            locationManager.desiredAccuracy = locationAccuracy[1]
            
            // アップデートする距離半径(m)
            locationManager.distanceFilter = 10
            
            // 位置情報の取得を開始
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // 最初のデータ
        let location = locations.first
        // 緯度
        let latitude = location?.coordinate.latitude
        // 経度
        let longitude = location?.coordinate.longitude
        
        print("latitude: \(latitude!)")
        print("longitude: \(longitude!)")
        
        let currentLocation:String = "latitude: \(latitude!)\nlongitude: \(longitude!)"
        locationLabel.text = currentLocation
        
    }
}
