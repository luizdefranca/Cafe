//
//  RatingViewController.swift
//  Cafe
//
//  Created by Luiz on 10/30/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBlurEffect()

        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translationTransform = CGAffineTransform.init(translationX: 0, y: -1000)

        let combinedTransform = scaleTransform.concatenating(translationTransform)

        containerView.transform = combinedTransform


        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        containerView.layer.shadowOpacity = 0.6

    }

    override func viewDidAppear(_ animated: Bool) {
        animateView()
    }

    // MARK: - Outlet

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var containerView: UIView!

    // MARK:
    @IBAction func SaveRating(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = view.bounds
        backgroundImage.addSubview(blurEffectView)
    }

    private func animateView(){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
             self.containerView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

