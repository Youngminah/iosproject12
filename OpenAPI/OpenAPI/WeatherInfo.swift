//
//  WeatherInfo.swift
//  OpenAPI
//
//  Created by meng on 2021/03/06.
//

import Foundation


struct WeatherInfo: Codable{
    let timezone: String
    let current: Current
    let hourly: [Hourly]
}

struct Current: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct Hourly: Codable{
    let dt: Int
    let temp: Double
    let weather: [Weather]
}


struct Weather: Codable{
    let main: String
    let description: String
    let icon: String
}
