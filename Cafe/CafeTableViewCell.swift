//
//  CafeTableViewCell.swift
//  Cafe
//
//  Created by Luiz on 9/6/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {

    //MARK: - Outlet
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet{
            self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.frame.height / 2
            self.thumbnailImageView.clipsToBounds = true
            self.thumbnailImageView.layer.borderColor = UIColor(named: "Salmon")?.cgColor
            self.thumbnailImageView.layer.borderWidth = 2.0
            self.thumbnailImageView.layer.shadowRadius = 30
            self.thumbnailImageView.layer.shadowOpacity = 0.6
            self.thumbnailImageView.layer.shadowOffset = CGSize.zero
        }
    }

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!


    //MARK: - LifeCycle



}
