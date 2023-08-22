//
//  NewsSourcesViewController.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import UIKit

// MARK: - Delegate for ViewModel
protocol NewsSourcesViewControllerDelegate: AnyObject {
    func reloadNewsSourceTableView()
    func changeLoadingIndicatorStatus()
}

class NewsSourcesViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var newsSourceTableView: UITableView!
    
    let viewModel = NewsSourcesViewModel(service: NewsService())
    
    let loadingIndicator = UIActivityIndicatorView(style: .large)
   
    var selectedCategories: Set<Category.RawValue> = []
    
    let categoryCell = CategoryCollectionViewCell()
    let newsSourceCell = SourceTableViewCell()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCategoryCollectionView()
        configureNewsSourceTableView()
        configureLoadingIndicator()
        
        viewModel.getNewsSources()
        viewModel.view = self
    }
    
    private func configureCategoryCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(categoryCell.nib, forCellWithReuseIdentifier: categoryCell.id)
    }
    
    private func configureNewsSourceTableView() {
        newsSourceTableView.delegate = self
        newsSourceTableView.dataSource = self
        newsSourceTableView.register(newsSourceCell.nib, forCellReuseIdentifier: newsSourceCell.id)
        
        newsSourceTableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: newsSourceTableView.frame.width, height: 0.5))
        separatorView.backgroundColor = UIColor.gray
        newsSourceTableView.tableHeaderView = separatorView
    }
    
    private func configureLoadingIndicator() {
        loadingIndicator.color = .gray
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        
        loadingIndicator.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewsListVC" {
            if let newsSource = sender as? NewsSource {
                if let destinationVC = segue.destination as? NewsListViewController {
                    destinationVC.selectedNewsSourceID = newsSource.id ?? ""
                }
            }
        }
    }
    
}

// MARK: - categoryCollectionView Delegate and DataSource
extension NewsSourcesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = Category.allCases[indexPath.row].rawValue
        
        if selectedCategories.contains(selectedCategory) {
            selectedCategories.remove(selectedCategory)
        } else {
            selectedCategories.insert(selectedCategory)
        }
        categoryCollectionView.reloadData()
        viewModel.updateNewsTableWithSelectedCategories(with: selectedCategories)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell.id, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let category = Category.allCases[indexPath.row].rawValue
        let isSelected = selectedCategories.contains(category)
        
        cell.setCell(isSelected: isSelected, title: category)
        
        return cell
    }
    
}

// MARK: - newsSourceTableView Delegate and DataSource
extension NewsSourcesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        !selectedCategories.isEmpty ? viewModel.filteredNewsSources.count : viewModel.newsSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: newsSourceCell.id, for: indexPath) as? SourceTableViewCell else {
            return UITableViewCell()
        }
        
        let item: NewsSource
        
        if !selectedCategories.isEmpty {
            item = viewModel.filteredNewsSources[indexPath.row]
        } else {
            item = viewModel.newsSources[indexPath.row]
        }
        
        cell.setCell(title: item.name, description: item.description)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem: NewsSource
        
        if !selectedCategories.isEmpty {
            selectedItem = viewModel.filteredNewsSources[indexPath.row]
        } else {
            selectedItem = viewModel.newsSources[indexPath.row]
        }
        
        performSegue(withIdentifier: "toNewsListVC", sender: selectedItem)
    }
    
}

// MARK: - NewsSourcesViewControllerDelegate for ViewModel
extension NewsSourcesViewController: NewsSourcesViewControllerDelegate {
    
    func reloadNewsSourceTableView() {
        newsSourceTableView.reloadOnMainThread()
    }
    
    func changeLoadingIndicatorStatus() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
    }
    
}
