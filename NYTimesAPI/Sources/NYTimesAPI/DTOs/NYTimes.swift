//
//  NYTimes.swift
//
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation

// MARK: - Story

/// A struct representing a story from the NY Times.
public struct Story: Decodable {
    public let id: Int?                 // The unique identifier of the story.
    public let title: String?           // The title of the story.
    public let abstract: String?        // A summary or brief description of the story.
    public let url: String?             // The URL of the story.
    public let byline: String?          // The author or source of the story.
    public let item_type: String?       // The type of the story item.
    public let updated_date: Date?      // The date when the story was last updated.
    public let created_date: Date?      // The date when the story was created.
    public let published_date: Date?    // The date when the story was published.
    public let material_type_facet: String?    // The facet of the material type.
    public let kicker: String?          // A headline or subheading of the story.
    public let multimedia: [Multimedia]?    // An array of multimedia content associated with the story.

    /// The URL of the thumbnail image associated with the story, if available.
    public var thumbnailURL: String? {
        return multimedia?.first(where: { $0.format == "Large Thumbnail" })?.url
    }

    /// The URL of the large image associated with the story, if available.
    public var largeImageURL: String? {
        return multimedia?.first(where: { $0.format == "Super Jumbo" })?.url
    }
}

// MARK: - Multimedia

/// A struct representing multimedia content associated with a story.
public struct Multimedia: Decodable {
    public let url: String     // The URL of the multimedia content.
    public let format: String  // The format of the multimedia content.
}

// MARK: - TopStoriesResult

/// A struct representing the top stories result from the NY Times.
public struct TopStoriesResult: Decodable {
    public let results: [Story]    // An array of stories.
}
