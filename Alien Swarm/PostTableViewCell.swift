//
//  PostTableViewCell.swift
//  Alien Swarm
//
//  Created by Ben Yorke on 10/17/14.
//  Copyright (c) 2014 Ben Yorke. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var newImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
