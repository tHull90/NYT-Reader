//
//  JSONTableViewCell.swift
//  JSON
//
//  Created by Timothy Hull on 6/27/17.
//  Copyright © 2017 Sponti. All rights reserved.
//

import UIKit

class JSONTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellDetailText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
