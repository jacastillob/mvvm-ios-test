//
//  SavedHeadlineTableViewCell.swift
//  MVVMMedibankTest
//
//  Created by Jonathan Castillo on 18/8/21.
//

import UIKit

class SavedHeadlineTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleHeadlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var souceLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    
    var savedHeadline : SavedHeadlineData? {
        didSet {
            titleHeadlineLabel.text = savedHeadline?.title
            descriptionLabel.text = savedHeadline?.description
            souceLabel.text = savedHeadline?.sourceName
            // Create URL
            guard let imageUrl:URL = URL(string: savedHeadline?.urlToImage ?? "https://miro.medium.com/max/880/0*H3jZONKqRuAAeHnG.jpg") else {
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

extension UIImageView {
    func loadImge(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}

