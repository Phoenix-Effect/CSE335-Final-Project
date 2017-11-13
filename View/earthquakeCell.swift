//
//  earthquakeCell.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/12/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit

class earthquakeCell: UITableViewCell {
    
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var magnitude: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
