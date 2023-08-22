//
//  NewsListViewController.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import UIKit

// MARK: - Delegate for ViewModel
protocol NewsListViewControllerDelegate: AnyObject {
    func reloadNewsCollectionView()
    func changeLoadingIndicatorStatus()
}

class NewsListViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    let viewModel = NewsListViewModel(service: NewsService())
    
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    let newsCell = NewsCollectionViewCell()
    
    lazy var selectedNewsSourceID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNewsCollectionView()
        configureLoadingIndicator()
        
        viewModel.view = self
        viewModel.getNews(from: selectedNewsSourceID)
        //viewModel.startRefreshingTimer()
    }
    
    private func configureNewsCollectionView() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        newsCollectionView.register(newsCell.nib, forCellWithReuseIdentifier: newsCell.id)
        
        newsCollectionView.register(
            HeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.id
        )
    }
    
    private func configureLoadingIndicator() {
        loadingIndicator.color = .gray
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        
        loadingIndicator.startAnimating()
    }

}

// MARK: - newsCollectionView Delegate and DataSource
extension NewsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCell.id, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setCell(with: viewModel.news[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: newsCollectionView.frame.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: newsCollectionView.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.id, for: indexPath) as! HeaderCollectionReusableView
           
            headerView.sliderNews = viewModel.sliderNews
            return headerView
        }
        return UICollectionReusableView()
    }
    
}

// MARK: - NewsListViewControllerDelegate for ViewModel
extension NewsListViewController: NewsListViewControllerDelegate {
    
    func reloadNewsCollectionView() {
        newsCollectionView.reloadOnMainThread()
    }
    
    func changeLoadingIndicatorStatus() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
    }
    
}
