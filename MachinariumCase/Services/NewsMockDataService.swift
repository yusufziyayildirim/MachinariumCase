//
//  NewsMockDataService.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

class NewsMockDataService: NewsServiceProtocol{
    
    func getNewsSources(completion: @escaping (Result<NewsSourcesResponse, Error>) -> Void) {
        // Mock News Sources
    }
    
    func getNews(from sourceId: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        // Mock News
    }
    
}
