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

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView! {

        didSet {

            self.thumbnailImage.layer.cornerRadius = self.thumbnailImage.bounds.height / 2
            self.thumbnailImage.clipsToBounds = true
            self.thumbnailImage.layer.borderColor = UIColor(named: "Pastel")?.cgColor
            self.thumbnailImage.layer.borderWidth = 2.0
            self.thumbnailImage.contentMode = UIView.ContentMode.scaleAspectFill
        }
    }

    //Proprieties
    var cafe: Cafe? {
        didSet {
            self.nameLabel.text = self.cafe?.name
            self.locationLabel.text = self.cafe?.address

            if let imageString = self.cafe?.image {
             let imaged =   loadImage(urlString: imageString)
            }

        }
    }

    var imageCache = NSCache<AnyObject, AnyObject>()


    func loadImage(urlString: String) -> UIImage? {
        if let imageCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.thumbnailImage.image = imageCache
            return nil
        }

        guard let url = URL(string: urlString) else { return  nil}
        let request = URLRequest(url: url)
        var imagei : UIImage?
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription) at line \(#line) in the function \(#function) on the file \(#file) ")
            }

            guard let data = data else { return }
            if let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                print("\(image)")
                DispatchQueue.main.async {
                    self.thumbnailImage.image = image
                }
              imagei = image
            }

        }.resume()
        return imagei
    }

    func showActivityIndicator(view: UIView){
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = view.center
        activityView.frame = view.frame
        activityView.tag = 100
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        activityView.startAnimating()
    }

    func hideActivityIndicator(view: UIView) {
        if let activityView = view.viewWithTag(100) as? UIActivityIndicatorView {
            activityView.stopAnimating()
        }

    }
//    var thubmnailImage: UIImage? {
//        didSet{
//            var imageLayer = UIImageView(image: self.thubmnailImage)
////            imageLayer.center = thumbnaiView.center
//            imageLayer.frame = thumbnaiView.frame
//            imageLayer.layer.cornerRadius = imageLayer.frame.height / 2
//            imageLayer.layer.masksToBounds = true
////
////            var containerLayer : CALayer = CALayer()
////            containerLayer.frame = thumbnaiView.frame
////            containerLayer.shadowColor = UIColor.gray.cgColor
////            containerLayer.shadowRadius = 3.0
////            containerLayer.opacity = 0.7
////            containerLayer.addSublayer(imageLayer.layer)
//
////            self.thubmnailImage.
//            self.thumbnaiView.layer.contentsGravity = CALayerContentsGravity.resizeAspect
//            self.thumbnaiView.layer.contents = self.thubmnailImage?.cgImage
//
//
//        }
//    }
    //MARK: - LifeCycle



}
