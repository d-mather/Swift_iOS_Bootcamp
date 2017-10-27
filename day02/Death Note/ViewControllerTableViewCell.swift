//
//  ViewControllerTableViewCell.swift
//  Death Note
//
//  Created by Dillon MATHER on 2017/10/05.
//  Copyright © 2017 Dillon MATHER. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myDesc: UILabel!
    @IBOutlet weak var myDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
