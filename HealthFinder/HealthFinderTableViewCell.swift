//
//  HealthFinderTableViewCell.swift
//  HealthFinder
//
//  Created by Jacqueline Lin on 10/9/16.
//  Copyright © 2016 CS96SI. All rights reserved.
//

import UIKit

class HealthFinderTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
