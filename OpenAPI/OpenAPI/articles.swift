//
//  articles.swift
//  OpenAPI
//
//  Created by meng on 2021/03/04.
//

import Foundation


struct Response: Codable {
    let totalResults: Int
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults
        case articles
    }
}

struct Article: Codable {
    let source: From
    let author: String?
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case url
        case urlToImage
        case publishedAt
    }
}

struct From: Codable{
    let name : String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
