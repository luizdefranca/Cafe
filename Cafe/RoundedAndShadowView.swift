//
//  RoundedAndShadowView.swift
//  Cafe
//
//  Created by Luiz on 10/6/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class RoundedAndShadowView: UIImageView {

    var imageLayer = CALayer()
    var roundedLayer = CALayer()
    var radius : CGFloat = 3
    func setupImageLayer() {
        imageLayer.contents = self.image
        imageLayer.masksToBounds = true
        imageLayer.frame = self.frame
        imageLayer.cornerRadius = radius
        imageLayer.masksToBounds = true
    }

    func setupRoundedLayer(){

        roundedLayer.shadowColor = UIColor.darkGray.cgColor
        roundedLayer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: radius).cgPath
//        roundedLayer.shadowOffset = CGSize(width: offset, height: offset)
        roundedLayer.shadowOpacity = 0.7
        roundedLayer.shadowRadius = 3
        roundedLayer.frame = self.frame
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\(#function)")
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("\(#function)")
        setupView()
    }


    override func layoutSubviews() {
        print("\(#function)")
        self.layer.addSublayer(imageLayer)
        self.layer.insertSublayer(roundedLayer, at: 0)
    }
    func setupView(){
        setupImageLayer()
        setupRoundedLayer()
    }
}
