//
//  NewsResponse.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let news: [News]?
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults
        case news = "articles"
    }
}
