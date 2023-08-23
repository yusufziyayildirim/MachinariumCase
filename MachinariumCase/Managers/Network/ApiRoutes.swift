//
//  ApiRoutes.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

enum ApiRoutes {
    static let baseUrl = "https://newsapi.org/v2"
    static let apiKey = "85de1d6663ee467082fe162aa9d98391"
    
    //NewsApi Endpoints
    static let newsSources = "\(baseUrl)/sources"
    static let newsList = "\(baseUrl)/top-headlines"
}
