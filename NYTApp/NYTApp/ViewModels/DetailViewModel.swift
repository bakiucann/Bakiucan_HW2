//
//  DetailViewModel.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import Foundation
import NYTimesAPI

class DetailViewModel {
    private let story: Story

    init(story: Story) {
        self.story = story
    }

    // MARK: - Properties

    var navigationTitle: String {
        return "Story Detail"
    }

    var title: String? {
        return story.title
    }

    var author: String? {
        return story.byline
    }

    var description: String? {
        return story.abstract
    }

    var largeImageURL: URL? {
        if let urlString = story.largeImageURL, let url = URL(string: urlString) {
            return url
        }
        return nil
    }

    var storyURL: URL? {
        if let urlString = story.url, let url = URL(string: urlString) {
            return url
        }
        return nil
    }
}
