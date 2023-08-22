//
//  NewsService.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

class NewsService: NewsServiceProtocol{
   
    private let manager: NetworkManager? = DependencyContainer.shared.resolve()
    
    func getNewsSources(completion: @escaping (Result<NewsSourcesResponse, Error>) -> Void) {
        let queryParams = ["apiKey" : ApiRoutes.apiKey, "language" : Language.en] as [String : Any]
        let getSourcesRequest = ApiRequest(url: ApiRoutes.newsSources, method: .GET, headers: nil, queryParams: queryParams, body: nil)
        
        manager?.request(getSourcesRequest, completion: { (result: Result<NewsSourcesResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getNews(from sourceId: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        let queryParams = ["apiKey" : ApiRoutes.apiKey, "sources" : sourceId]
        let getNewsRequest = ApiRequest(url: ApiRoutes.newsList, method: .GET, headers: nil, queryParams: queryParams, body: nil)
        
        manager?.request(getNewsRequest, completion: { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
}
