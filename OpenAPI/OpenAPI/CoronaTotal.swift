//
//  CoronaTotal.swift
//  OpenAPI
//
//  Created by meng on 2021/03/05.
//

import Foundation


struct TotalCorona: Codable {
    let TotalCase: String
    let TotalRecovered: String
    let TotalDeath: String
    let NowCase: String
    let city1n: String
    let city2n: String
    let city3n: String
    let city4n: String
    let city5n: String
    let city1p: String
    let city2p: String
    let city3p: String
    let city4p: String
    let city5p: String
    let recoveredPercentage: Double
    let deathPercentage: Double
    let checkingCounter: String
    let checkingPercentage: String
    let caseCount: String
    let casePercentage: String
    let TotalChecking: String
    let TodayRecovered: String
    let TodayDeath: String
    let TotalCaseBefore: String
    let updateTime: String
}
