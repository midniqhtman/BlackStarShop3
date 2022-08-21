//
//  BasketTableViewCell.swift
//  BlackStarShop
//
//  Created by Байсаев Зубайр on 21.08.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var basketImage: UIImageView!
    @IBOutlet weak var basketName: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
