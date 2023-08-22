//
//  ApiRoutes.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

enum ApiRoutes {
    static let baseUrl = "https://newsapi.org/v2"
    static let apiKey = "0c0b64ca79094998a4ff634c284f3b56"
    
    //NewsApi Endpoints
    static let newsSources = "\(baseUrl)/sources"
    static let newsList = "\(baseUrl)/top-headlines"
}
