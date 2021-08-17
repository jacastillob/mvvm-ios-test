//
//  SourceTableViewCell.swift
//  MVVMMedibankTest
//
//  Created by Jonathan Castillo on 16/8/21.
//
import UIKit

class SourceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameSourceLabel: UILabel!
    var source : SourceData? {
        didSet {
            nameSourceLabel.text = source?.name
            //descriptionLabel.text = headline?.title
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
