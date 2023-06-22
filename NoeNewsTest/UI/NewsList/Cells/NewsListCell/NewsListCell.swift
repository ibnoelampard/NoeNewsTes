//
//  NewsListCell.swift
//  NoeNewsTest
//
//  Created by ibnuhakim on 22/06/23.
//

import UIKit
import SDWebImage

class NewsListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(imgUrl: String, title: String, description: String) {
        ivCover.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: ""))
        lblTitle.text = title
        lblDescription.text = description
    }
    
}
