//
//  HeaderCollectionReusableView.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 22.08.2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static public let id = "HeaderCollectionReusableView"
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var sliderNews = [News]()
    
    private let newsCell = NewsCollectionViewCell()
    private var timer = Timer()
    private var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemGreen
        pageControl.numberOfPages = sliderNews.count
        configureSliderCollectionView()
    }
    
    func configureSliderCollectionView() {
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(newsCell.nib, forCellWithReuseIdentifier: newsCell.id)
    }
    
    func startTimer() {
        timer = Timer(timeInterval: 5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if currentIndex < sliderNews.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
}

extension HeaderCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCell.id, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setCell(with: sliderNews[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
