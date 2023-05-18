//
//  UserDefaults+Extensions.swift
//  NYTApp
//
//  Created by Baki Uçan on 17.05.2023.
//

import Foundation

extension UserDefaults {
    static var favorites: [Int] {
        get {
            return UserDefaults.standard.array(forKey: "Favorites") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Favorites")
        }
    }

    static func toggleFavorite(_ storyId: Int) {
        var favorites = UserDefaults.favorites

        if favorites.contains(storyId) {
            favorites.removeAll { $0 == storyId }
        } else {
            favorites.append(storyId)
        }

        UserDefaults.favorites = favorites
    }
}
