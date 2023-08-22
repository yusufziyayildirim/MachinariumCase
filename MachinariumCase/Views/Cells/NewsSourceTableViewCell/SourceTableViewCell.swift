//
//  SourceTableViewCell.swift
//  MachinariumCase
//
//  Created by Yusuf Ziya YILDIRIM on 21.08.2023.
//

import UIKit

final class SourceTableViewCell: UITableViewCell {

    public let id = "newsSourceTableViewCell"
    public let nib = UINib(nibName: "SourceTableViewCell", bundle: nil)
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setCell(title: String?, description: String?){
        titleLabel.text = title?.capitalized
        descriptionLabel.text = description?.capitalized
    }
    
}
