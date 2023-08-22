//
//  NewsServiceProtocol.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

protocol NewsServiceProtocol{
    func getNewsSources(completion: @escaping (Result<NewsSourcesResponse, Error>) -> Void)
    func getNews(from sourceId: String, completion: @escaping (Result<NewsResponse, Error>) -> Void)
}
