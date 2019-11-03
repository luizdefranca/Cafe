//
//  DetailTableViewCell.swift
//  Cafe
//
//  Created by Luiz on 10/16/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var fieldLb: UILabel!
    @IBOutlet weak var valueLb: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
