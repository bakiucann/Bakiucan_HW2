//
//  ListViewModel.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import Foundation
import NYTimesAPI

class ListViewModel {
    private var stories: [Story] = []
    private let nyTimesService: NYTimesServiceProtocol

    var numberOfStories: Int {
        return stories.count
    }

    init(nyTimesService: NYTimesServiceProtocol = NYTimesService()) {
        self.nyTimesService = nyTimesService
    }

    func fetchTopStories(completion: @escaping (Result<Void, Error>) -> Void) {
        nyTimesService.fetchTopStories { [weak self] result in
            switch result {
            case .success(let stories):
                self?.stories = stories
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func storyViewModel(at index: Int) -> StoryViewModel {
        return StoryViewModel(story: stories[index])
    }
}

struct StoryViewModel {
    let story: Story

    init(story: Story) {
        self.story = story
    }

    var title: String? {
        return story.title
    }

    var author: String? {
        return story.byline
    }

    var thumbnailURL: URL? {
        if let urlString = story.thumbnailURL, let url = URL(string: urlString) {
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
