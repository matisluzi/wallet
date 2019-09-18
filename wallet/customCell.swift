//
//  customCell.swift
//  wallet
//
//  Created by Matis Luzi on 9/18/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    
    @IBOutlet var imageLetter: UILabel!
    @IBOutlet var purchaseNameLabel: UILabel!
    @IBOutlet var purchaseDateLabel: UILabel!
    @IBOutlet var purchaseAmountLabel: UILabel!
    
    func showCellData(name:String, date:String, amount:Double) {
        if !(name=="None"){
            imageLetter.text = String(name.prefix(1)).capitalized
        }
        else {
            imageLetter.text = "?"
        }
        purchaseNameLabel.text = name
        purchaseDateLabel.text = date
        purchaseAmountLabel.text = String(amount) + " KM"
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
