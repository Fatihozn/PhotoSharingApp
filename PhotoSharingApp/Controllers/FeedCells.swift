//
//  FeedCells.swift
//  PhotoSharingApp
//
//  Created by Fatih Özen on 27.01.2023.
//

import UIKit

class FeedCells: UITableViewCell {
    
    
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commendLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
