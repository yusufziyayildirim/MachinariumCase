//
//  NewsSourcesViewModel.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import Foundation

protocol NewsSourcesViewModelProtocol {
    var view: NewsSourcesViewControllerDelegate? { get set }
    
    func getNewsSources()
    func updateNewsTableWithSelectedCategories(with selectedCategories: Set<Category.RawValue>)
}

class NewsSourcesViewModel {
    
    // MARK: - Service
    private let service: NewsServiceProtocol?
    
    // MARK: - View
    weak var view: NewsSourcesViewControllerDelegate?
    
    // MARK: - Properties
    lazy var newsSources = [NewsSource]()
    lazy var filteredNewsSources = [NewsSource]()
    
    // MARK: - Initialization
    init(service: NewsServiceProtocol) {
        self.service = service
    }
}


// MARK: - NewsSourcesViewModelProtocol
extension NewsSourcesViewModel: NewsSourcesViewModelProtocol {
   
    func getNewsSources() {
        service?.getNewsSources { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.newsSources = response.sources ?? []
                self.view?.reloadNewsSourceTableView()
                self.view?.changeLoadingIndicatorStatus()
            case .failure(let error):
                print("Error fetching news sources: \(error)")
            }
        }
    }
    
    func updateNewsTableWithSelectedCategories(with selectedCategories: Set<Category.RawValue>) {
        self.filteredNewsSources = newsSources.filter { selectedCategories.contains($0.category?.rawValue ?? "") }
        view?.reloadNewsSourceTableView()
    }
    
}
