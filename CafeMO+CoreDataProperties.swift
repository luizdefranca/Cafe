//
//  CafeMO+CoreDataProperties.swift
//  Cafe
//
//  Created by Luiz on 11/16/19.
//  Copyright © 2019 Luiz. All rights reserved.
//
//

import Foundation
import CoreData


extension CafeMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CafeMO> {
        return NSFetchRequest<CafeMO>(entityName: "Cafe")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var isClosed: Bool
    @NSManaged public var distance: Double
    @NSManaged public var title: String?
    @NSManaged public var price: String?
    @NSManaged public var rating: Double
    @NSManaged public var webPage: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var phone: String?
    @NSManaged public var city: String?
    @NSManaged public var address: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var transactions: [String]?

}
