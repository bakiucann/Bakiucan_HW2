//
//  UserDefaults+Extensions.swift
//  NYTApp
//
//  Created by Baki Uçan on 17.05.2023.
//

import Foundation

extension UserDefaults {
    static let favoritesKey = "Favorites"

    func getFavorites() -> [Int] {
        return array(forKey: UserDefaults.favoritesKey) as? [Int] ?? []
    }

    func addFavorite(_ storyId: Int) {
        var favorites = getFavorites()
        if !favorites.contains(storyId) {
            favorites.append(storyId)
            set(favorites, forKey: UserDefaults.favoritesKey)
        }
    }

    func removeFavorite(_ storyId: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: storyId) {
            favorites.remove(at: index)
            set(favorites, forKey: UserDefaults.favoritesKey)
        }
    }

    func isFavorite(_ storyId: Int) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(storyId)
    }
}
