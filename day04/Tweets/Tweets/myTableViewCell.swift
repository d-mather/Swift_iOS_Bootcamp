//
//  myTableViewCell.swift
//  Tweets
//
//  Created by Dillon MATHER on 2017/10/08.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
