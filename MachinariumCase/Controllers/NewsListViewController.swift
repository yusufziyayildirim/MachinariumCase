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
    
    var selectedNewsSource: NewsSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedNewsSource?.name
        
        configureNewsCollectionView()
        configureLoadingIndicator()
        
        
        viewModel.view = self
        viewModel.getNews(from: selectedNewsSource?.id ?? "")
        //viewModel.startRefreshingTimer()
    }
    
    private func configureNewsCollectionView() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        newsCollectionView.register(NewsCollectionViewCell.nib, forCellWithReuseIdentifier: NewsCollectionViewCell.id)
        
        newsCollectionView.register(HeaderCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.id)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.id, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let lineView = UIView(frame: CGRect(x: 0, y: cell.bounds.height - 1, width: cell.bounds.width, height: 0.5))
        lineView.backgroundColor = UIColor.systemGray
        cell.addSubview(lineView)
        
        cell.setCell(with: viewModel.news[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: newsCollectionView.frame.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: newsCollectionView.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.id, for: indexPath) as? HeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        headerView.configureSliderCollectionView(sliderNews: viewModel.sliderNews)
        
        let lineView = UIView(frame: CGRect(x: 0, y: headerView.bounds.height - 1, width: headerView.bounds.width, height: 0.3))
        lineView.backgroundColor = UIColor.systemGray
        headerView.addSubview(lineView)
        
        return headerView
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
