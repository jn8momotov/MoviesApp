//
//  SaveMovie+CoreDataProperties.swift
//  MoviesApp
//
//  Created by Евгений on 24/11/2018.
//  Copyright © 2018 Momotov. All rights reserved.
//
//

import Foundation
import CoreData


extension SaveMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveMovie> {
        return NSFetchRequest<SaveMovie>(entityName: "SaveMovie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var genres: String?
    @NSManaged public var tagline: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var poster: NSData?
    @NSManaged public var overview: String?
    @NSManaged public var language: String?
    @NSManaged public var popularity: Double
    @NSManaged public var adult: Bool
    @NSManaged public var budget: Int32
    @NSManaged public var revenue: Int32
    @NSManaged public var runtime: Int32
    @NSManaged public var productions: String?

}
