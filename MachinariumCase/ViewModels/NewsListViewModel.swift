//
//  NewsListViewModel.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

protocol NewsListViewModelProtocol {
    var view: NewsListViewControllerDelegate? { get set }
    
    func getNews(from id: String)
    func startRefreshingTimer()
}

class NewsListViewModel {
    
    // MARK: - Service
    private let service: NewsServiceProtocol?
    
    // MARK: - View
    weak var view: NewsListViewControllerDelegate?
    
    // MARK: - Properties
    lazy var news = [News]()
    lazy var sliderNews = [News]()
    lazy var selectedNewsSourceID: String = ""
    
    private var refreshTimer: Timer?
    
    // MARK: - Initialization
    init(service: NewsServiceProtocol) {
        self.service = service
    }

    // MARK: - Private Methods
    @objc private func refreshNews() {
        getNews(from: selectedNewsSourceID)
    }
    
}

// MARK: - NewsListViewModelProtocol
extension NewsListViewModel: NewsListViewModelProtocol{
    
    func getNews(from id: String) {
        selectedNewsSourceID = id
        service?.getNews(from: id, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.news = response.news ?? []
                self.sliderNews = Array(self.news.prefix(3))
                self.news.removeFirst(3)
                
                self.view?.reloadNewsCollectionView()
                self.view?.changeLoadingIndicatorStatus()
            case .failure(let error):
                print("Error fetching news sources: \(error)")
            }
        })
    }

    func startRefreshingTimer() {
        refreshTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refreshNews), userInfo: nil, repeats: true)
    }
    
}
