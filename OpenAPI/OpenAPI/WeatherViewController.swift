//
//  WeatherViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/05.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
        

    @IBOutlet weak var currentTimeLabel: UILabel!
    
    var models: WeatherInfo?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var locationLarge: String?
    var locationSmall: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
        requestWeatherForLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    
//    //헤더뷰 어떻게 표시?
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind { // kind의 종류는 크게 해더와 푸터가 있음
//        //헤더인 케이스
//        case UICollectionView.elementKindSectionHeader:
//            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
//                return UICollectionReusableView()
//            }
//            return header
//        default:
//            return UICollectionReusableView()
//        }
//    }
    

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation(){
//        guard let currentLocation = currentLocation else {
//            return
//        }
//        let long = currentLocation.coordinate.longitude
//        let lat = currentLocation.coordinate.latitude
        
        let lat = 37.535978
        let lon = 127.071539
        let findLocation: CLLocation = CLLocation(latitude: lat, longitude: lon)
        let geoCoder: CLGeocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") // Korea
        geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (place, error) in
            if let address: [CLPlacemark] = place {
                self.locationLarge = address.last?.administrativeArea
                self.locationSmall = address.last?.locality
                print("\(self.locationLarge) | \(self.locationSmall)")
                guard let str1 = self.locationLarge, let str2 = self.locationSmall else {
                    return
                }
                self.navigationItem.title = str1 + " " + str2
            }
        }
    
        
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,daily&appid=2951cd83b9f3c771d11f73a41a64a730"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    guard let result = response.data else { return }
                    do{
                        let response = try JSONDecoder().decode(WeatherInfo.self, from: result)
                        DispatchQueue.main.async{
                            self.models = response
                            let date = self.dayStringFromTime(unixTime: Double(response.current.dt))
                            self.currentTimeLabel.text = date + " 기준"
                            print(date)
                        }
                    }catch{
                        print(error)
                    }
                default:
                    print(response.result)
                    return
                }
        }
    }
    
    func dayStringFromTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mma"
        dateFormatter.timeZone = NSTimeZone(name: "Asia") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
    func updateUI(){
        
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    
}



class ListCell: UITableViewCell{
}
