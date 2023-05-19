//
//  FavoriteManager.swift
//  NYTApp
//
//  Created by Baki Uçan on 19.05.2023.
//

import UIKit
import CoreData

class FavoriteManager {
    static let shared = FavoriteManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()

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

