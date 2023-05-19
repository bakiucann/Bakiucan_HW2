//
//  FavoriteStory+CoreDataProperties.swift
//  
//
//  Created by Baki Uçan on 19.05.2023.
//
//

import Foundation
import CoreData


extension FavoriteStory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteStory> {
        return NSFetchRequest<FavoriteStory>(entityName: "FavoriteStory")
    }

    @NSManaged public var title: String?
    @NSManaged public var thumbnailURL: String?
    @NSManaged public var storyURL: String?
    @NSManaged public var author: String?

}
