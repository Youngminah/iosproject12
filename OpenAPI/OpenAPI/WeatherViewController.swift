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
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMaxTempLabel: UILabel!
    @IBOutlet weak var currentMinTempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
        if let modelInfo = models {
            return modelInfo.hourly.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else{
            return UITableViewCell()
        }
        guard let modelInfo = self.models else {
            return UITableViewCell()
        }
        let unixtime = Double(modelInfo.hourly[indexPath.row].dt)
        cell.dayStringFromTime(unixTime: unixtime)
        cell.tempHourlyLabel.text = self.kelvinToCelcious(kelvin: modelInfo.hourly[indexPath.row].temp) + "º"
        cell.weatherTimeImage.image = UIImage(named: self.weatherImageMatch(weather: modelInfo.hourly[indexPath.row].weather[0]))
        return cell
    }
    
    func requestWeatherForLocation(){
        guard let currentLocation = self.currentLocation else {
            return
        }
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        let findLocation: CLLocation = CLLocation(latitude: lat, longitude: lon)
        let geoCoder: CLGeocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") // Korea
        geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (place, error) in
            if let address: [CLPlacemark] = place {
                self.locationLarge = address.last?.administrativeArea
                self.locationSmall = address.last?.locality
                guard let str1 = self.locationLarge, let str2 = self.locationSmall else {
                    return
                }
                self.currentLocationLabel.text = str1 + " " + str2
            }
        }
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,daily&appid=2951cd83b9f3c771d11f73a41a64a730"
        //날씨 API 불러오기
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    guard let result = response.data else { return }
                    do{
                        let response = try JSONDecoder().decode(WeatherInfo.self, from: result)
                        DispatchQueue.main.async{
                            self.models = response
                            guard let modelInfo = self.models else{
                                return
                            }
                            self.updateUI(modelInfo: modelInfo)
                            self.tableView.reloadData()
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
    
    func updateUI(modelInfo: WeatherInfo){
        self.currentTempLabel.text = self.kelvinToCelcious(kelvin: modelInfo.current.temp) + "º"
        self.currentMaxTempLabel.text = self.kelvinToCelcious(kelvin: modelInfo.current.feels_like) + "º"
        self.currentMinTempLabel.text = String(modelInfo.current.humidity) + "%"
        self.currentWeatherImage.image = UIImage(named: self.weatherImageMatch(weather: modelInfo.current.weather[0]))
    }
    
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func kelvinToCelcious(kelvin: Double) -> String{
        let temp = kelvin - 273.15
        let result = String(format: "%.1f",temp)
        return result
    }
    
    func weatherImageMatch(weather: Weather) -> String{
        if weather.main == "Clear"{
            return "sunny"
        }
        else if weather.description == "overcast clouds"{
            return "005-cloudy"
        }
        else if weather.description == "few clouds"{
            return "002-sunny"
        }
        else if weather.description == "scattered clouds"{
            return "001-cloudy day"
        }
        else if weather.main == "Clouds"{
            return "005-cloudy"
        }
        else{
            return "003-sunny"
        }
    }
}

class ListCell: UITableViewCell{
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherTimeImage: UIImageView!
    @IBOutlet weak var tempHourlyLabel: UILabel!
    
    func dayStringFromTime(unixTime: Double){
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월dd일 HH:mma"
        dateFormatter.timeZone = NSTimeZone(name: "Asia") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        let arr = dateString.components(separatedBy: " ")
        dayLabel.text = arr[0]
        timeLabel.text = arr[1]
    }
}
