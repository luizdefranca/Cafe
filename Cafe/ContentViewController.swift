//
//  ContentViewController.swift
//  Cafe
//
//  Created by Luiz on 11/11/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    //MARK: - Outlets

    @IBOutlet weak var headingLabel: UILabel!

    @IBOutlet weak var contentImageView: UIImageView!

    @IBOutlet weak var contentLabel: UILabel!


    //MARK: - Properties

     var index = 0
     var heading = ""
     var imageFile = ""
     var content = ""


    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    //MARK: - View Methods

    private func setupView(){
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
    }

}
