//
//  FavoriteManager.swift
//  NYTApp
//
//  Created by Baki Uçan on 19.05.2023.
//

import UIKit
import CoreData

class FavoriteManager {
    static let shared = FavoriteManager()   // The shared instance of the FavoriteManager.

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()

    /// Adds a story to favorites.
    ///
    /// - Parameters:
    ///   - title: The title of the story.
    ///   - author: The author of the story.
    ///   - thumbnailURL: The URL of the thumbnail image associated with the story.
    ///   - storyURL: The URL of the full story.
    func addToFavorites(title: String, author: String, thumbnailURL: String, storyURL: String) {
        let context = persistentContainer.viewContext
        let favoriteStory = NSEntityDescription.insertNewObject(forEntityName: "FavoriteStory", into: context) as! FavoriteStory

        favoriteStory.title = title
        favoriteStory.author = author
        favoriteStory.thumbnailURL = thumbnailURL
        favoriteStory.storyURL = storyURL

        do {
            try context.save()
        } catch {
            print("Failed to add favorite: \(error.localizedDescription)")
        }
    }

    /// Removes a story from favorites.
    ///
    /// - Parameter title: The title of the story to remove.
    func removeFromFavorites(title: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteStory> = FavoriteStory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let favorites = try context.fetch(fetchRequest)
            if let favorite = favorites.first {
                context.delete(favorite)
                try context.save()
            }
        } catch {
            print("Failed to remove favorite: \(error.localizedDescription)")
        }
    }

    /// Checks if a story is in favorites.
    ///
    /// - Parameter title: The title of the story to check.
    /// - Returns: A boolean value indicating whether the story is in favorites or not.
    func isFavorite(title: String) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteStory> = FavoriteStory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let favorites = try context.fetch(fetchRequest)
            return !favorites.isEmpty
        } catch {
            print("Failed to check favorite: \(error.localizedDescription)")
        }

        return false
    }
}
