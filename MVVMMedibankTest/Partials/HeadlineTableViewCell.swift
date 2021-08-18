//
//  HeadlineTableViewCell.swift
//  MVVMTest
//  Created by Jonathan Castillo on 16/8/21.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleHeadlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var souceLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
    var headline : HeadlineData? {
        didSet {
            titleHeadlineLabel.text = headline?.title
            descriptionLabel.text = headline?.description
            souceLabel.text = headline?.source.name
            // Create URL
            guard let imageUrl:URL = URL(string: headline?.urlToImage ?? "https://miro.medium.com/max/880/0*H3jZONKqRuAAeHnG.jpg") else {
               return
           }
          headlineImageView.loadImge(withUrl: imageUrl)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
      
    }
}


