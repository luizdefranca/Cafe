//
//  Cafe.swift
//  Cafe
//
//  Created by Luiz on 9/10/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import Foundation
/*
 "total": 8228,
 "businesses": [
 {
 "rating": 4,
 "price": "$",
 "phone": "+14152520800",
 "id": "E8RJkjfdcwgtyoPMjQ_Olg",
 "alias": "four-barrel-coffee-san-francisco",
 "is_closed": false,
 "categories": [
 {
 "alias": "coffee",
 "title": "Coffee & Tea"
 }
 ],
 "review_count": 1738,
 "name": "Four Barrel Coffee",
 "url": "https://www.yelp.com/biz/four-barrel-coffee-san-francisco",
 "coordinates": {
 "latitude": 37.7670169511878,
 "longitude": -122.42184275
 },
 "image_url": "http://s3-media2.fl.yelpcdn.com/bphoto/MmgtASP3l_t4tPCL1iAsCg/o.jpg",
 "location": {
 "city": "San Francisco",
 "country": "US",
 "address2": "",
 "address3": "",
 "state": "CA",
 "address1": "375 Valencia St",
 "zip_code": "94103"
 },
 "distance": 1604.23,
 "transactions": ["pickup", "delivery"]
 },
 // ...
 ],
 "region": {
 "center": {
 "latitude": 37.767413217936834,
 "longitude": -122.42820739746094
 }
 }

 */

import MapKit

class Cafe : NSObject, MKAnnotation {

    //MARK: Proprieties

    //Required MkAnnotation Attributes

    var coordinate: CLLocationCoordinate2D  {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

    //Cached propriety
     var imageCache = NSCache<AnyObject, AnyObject>()

    //Proprieties from API
    var id: String = ""
    var name: String = ""
    var postalCode: String = ""
    var address: String = ""
    var city: String = ""
    var phone: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var imageURL: String = ""
    var webPage: String = ""
    var rating: Double = 0
    var price: String = ""
    var title: String? = ""
    var distance: Double = 0.0
    var isClosed: Bool = false
    var transactions: [String] = [String]()
    var image : UIImage?
    var subtitle: String? {
        return address
    }

    init(id : String,
            name: String,
         postalCode: String,
         address: String,
         city: String,
         phone: String,
         latitude: Double,
         longitude: Double,
         imageURL: String,
         webPage: String,
         rating: Double,
         price: String,
         title: String,
         distance: Double,
         isClosed: Bool,
         transactions: [String]) {
        self.id = id
        self.name = name
        self.phone = phone
        self.postalCode = postalCode
        self.address = address
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.imageURL = imageURL
        self.webPage = webPage
        self.rating = rating
        self.price = price
        self.title = name
        self.distance = distance
        self.isClosed = isClosed
        self.transactions = transactions
    }


    init(json: JsonObject) {

        if let id = json["id"] as? String { self.id = id}
        if let name = json["name"] as? String { self.name = name }
        if let image = json["image_url"] as? String { self.imageURL = image }
        if let isClosed = json["is_closed"] as? Bool { self.isClosed = isClosed }
        if let webPage = json["url"] as? String { self.webPage = webPage }
        if let rating = json["rating"] as? Double { self.rating = rating }
        if let price = json["price"] as? String { self.price = price }
        if let phone = json["display_phone"] as? String { self.phone = phone }
        if let distance = json["distance"] as? Double { self.distance = distance }
        if let coordinates = json["coordinates"] as? JsonObject {
            if let latitude = coordinates["latitude"] as? Double, let longitude = coordinates["longitude"] as? Double{
                self.latitude = latitude
                self.longitude = longitude
            }
        }

        if let transactions = json["transactions"] as? [String] {self.transactions = transactions }
        if let location = json["location"] as? JsonObject {
            if let address = location["address1"] as? String { self.address = address }
            if let city = location["city"] as? String { self.city = city }
            if let postalCode = location["zip_code"] as? String { self.postalCode = postalCode }
        }

        super.init()
        loadImage(urlString: imageURL)


    }
    
}

//MARK: Extensions


extension Cafe {

//Load image data from URL



    func loadImage(urlString: String) {
        if let imageCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageCache
            return
        }

        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription) at line \(#line) in the function \(#function) on the file \(#file) ")
            }

            guard let data = data else { return }
            if let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                print("\(image)")
                DispatchQueue.main.async {
                    self.image = image
                }
            }

        }.resume()

    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
