//
//  HeaderCollectionReusableView.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 22.08.2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static public let id = "HeaderCollectionReusableView"
    static public let nib = UINib(nibName: HeaderCollectionReusableView.id, bundle: nil)
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var sliderNews = [News]()
    
    private let newsCell = NewsCollectionViewCell()
    private var timer: Timer?
    private var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startTimer()
    }
    
    func configureSliderCollectionView(sliderNews: [News]) {
        self.sliderNews = sliderNews
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(newsCell.nib, forCellWithReuseIdentifier: newsCell.id)
        
        pageControl.numberOfPages = sliderNews.count
        pageControl.currentPage = currentIndex
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        sliderCollectionView.reloadData()
    }
    
    // Start the timer for auto-scrolling the slider
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }

    // Move to the next slider item
    @objc private func moveToNextIndex() {
        if currentIndex < sliderNews.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
    
    // Move to the slider with PageControl
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        let indexPath = IndexPath(item: selectedPage, section: 0)
        
        sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage
    }
}
