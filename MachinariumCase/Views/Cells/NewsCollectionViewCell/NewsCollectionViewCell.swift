//
//  NewsCollectionViewCell.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import UIKit
import SDWebImage

class NewsCollectionViewCell: UICollectionViewCell {
    
    static public let id = "newsCollectionViewCell"
    static public let nib = UINib(nibName: "NewsCollectionViewCell", bundle: nil)
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addToReadListButton: UIButton!
    
    var news: News? = nil
    var isNewsInCoreData = false

    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.layer.cornerRadius = 10
    }
    
    @IBAction func addToReadListBtn(_ sender: Any) {
        do {
            if isNewsInCoreData {
                try CoreDataManager.shared.removeNews(news: news)
                addToReadListButton.setTitle("Okuma listeme ekle", for: .normal)
            } else {
                try CoreDataManager.shared.addNews(news: news)
                addToReadListButton.setTitle("Okuma listemden çıkar", for: .normal)
            }
            
            isNewsInCoreData = !isNewsInCoreData
        } catch {
            print(error)
        }
    }
    
    func setCell(with news: News){
        self.news = news
        
        if let url = URL(string: news.urlToImage ?? "") {
            newsImageView.sd_setImage(with: url)
        }
        newsTitleLabel.text = news.title ?? "N/A"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let publishedDate = dateFormatter.date(from: news.publishedAt ?? "") {
            dateFormatter.dateFormat = "HH:mm:ss"
            let formattedDate = dateFormatter.string(from: publishedDate)
            dateLabel.text = formattedDate
        } else {
            dateLabel.text = "N/A"
        }
        
        isNewsInCoreData = CoreDataManager.shared.isNewsInCoreData(news: news)
        let buttonTitle = isNewsInCoreData ? "Okuma listemden çıkar" : "Okuma listeme ekle"
        addToReadListButton.setTitle(buttonTitle, for: .normal)
    }
    
}
