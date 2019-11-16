//
//  RatingStackView.swift
//  Cafe
//
//  Created by Luiz on 11/14/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

@IBDesignable
class RatingStackView: UIStackView {

    //MARK: Properties

    var starCount : Int = 5 {
        didSet {
            setupButtons()
        }
    }


    var btnBackgroundColor : UIColor = .white


    var btnHeight : CGFloat = 44.0 {
        didSet {
            setupButtons()
        }
    }


    var btnWidth: CGFloat = 44.00 {
        didSet {
            setupButtons()
        }
    }


    let kSpacing: CGFloat = 8.0


    var rating: Int = 0 {
        didSet {
            updateButtonSelection()
        }
    }

    private var ratingButtons = [UIButton]()

    override init(frame: CGRect){
        super.init(frame: frame)
        isUserInteractionEnabled = true
        spacing = kSpacing
        setupButtons()
    }

    required init(coder: NSCoder){
        super.init(coder: coder)
        setupButtons()
    }


    private func setupButtons(){
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        for _ in 0..<starCount {
            let button = UIButton()
//            button.frame.size = CGSize(width: btnHeight, height: btnWidth)
            button.backgroundColor = btnBackgroundColor
            button.setImage(#imageLiteral(resourceName: "emptyStar"), for: .normal)
            button.setImage( #imageLiteral(resourceName: "filledStar-1"),for: .selected)
//            button.setImage( #imageLiteral(resourceName: "highlightedStar") , for: .highlighted)
            button.setImage(#imageLiteral(resourceName: "highlightedStar"), for: [.highlighted, .selected])


            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: btnHeight).isActive = true
            button.widthAnchor.constraint(equalToConstant: btnWidth).isActive = true

            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            button.accessibilityLabel = "Set \(String(describing: index)) + 1 star rating"

            addArrangedSubview(button)
            ratingButtons.append(button)
        }



    }

    func updateButtonSelection() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
                let hintString : String?

            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }

            let valueString: String

            switch rating {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }

            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            }

        }


    @objc func ratingButtonTapped(button: UIButton){

        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("Button is not in the array of Buttons")
        }

        print("button tapped - index \(index)")

        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }

    }
}
