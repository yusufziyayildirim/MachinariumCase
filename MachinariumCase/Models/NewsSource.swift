//
//  Source.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    static var allCases: [Category] {
        return [.business, .entertainment, .general, .health, .science, .sports, .technology]
    }
}

enum Language: String, Codable {
    case en = "en"
}

struct NewsSource: Codable {
    let id, name, description: String?
    let url: String?
    let category: Category?
    let language: Language?
    let country: String?
}
