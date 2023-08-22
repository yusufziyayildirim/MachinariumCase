//
//  CategoryCollectionViewCell.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    public let id = "categoryCollectionViewCell"
    public let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    
    @IBOutlet weak private var bgView: UIView!
    @IBOutlet weak private var statusImage: UIImageView!
    @IBOutlet weak private var categoryTitleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCellUI()
    }

    private func configureCellUI() {
        layer.borderWidth = 0.5
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.gray.cgColor
    }
    
    public func setCell(isSelected: Bool, title: String){
        if isSelected {
            bgView.backgroundColor = UIColor.black
            categoryTitleLabel.textColor = UIColor.white
            statusImage.image = UIImage(systemName: "checkmark")
            statusImage.tintColor = UIColor.white
        } else {
            bgView.backgroundColor = UIColor.white
            categoryTitleLabel.textColor = UIColor.black
            statusImage.image = UIImage(systemName: "plus")
            statusImage.tintColor = UIColor.black
        }
        categoryTitleLabel.text = title.capitalized
    }

}
