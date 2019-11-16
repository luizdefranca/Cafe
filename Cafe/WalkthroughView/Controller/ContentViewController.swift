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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var forwardButton: UIButton!

    //MARK: - Properties

     var index = 0
     var heading = ""
     var imageFile = ""
     var content = ""


    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        pageControl.currentPage = index
        setupForwardButton()

    }

    //MARK: - Actions

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        switch index {
        case 0...1:

            let pageViewController  = parent as! WalkthroughPageViewController
                pageViewController.forward(for: index)
            pageControl.currentPage = index

        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }


    //MARK: - View Methods

    private func setupView(){
        headingLabel.text = heading
        contentLabel.text = content
        let image = UIImage(named: "\(imageFile).png")
        contentImageView.image = image
    }

    private func setupImageView() {
        contentImageView.layer.cornerRadius = 9.0
        contentImageView.layer.borderWidth = 2.0

        contentImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        contentImageView.clipsToBounds = true
    }

    private func setupForwardButton() {
        switch index {
        case 0...1:
            forwardButton.setTitle("NEXT", for: .normal)
        case 2:
            forwardButton.setTitle("DONE", for: .normal)

        default:
            break
        }
    }

    

}
