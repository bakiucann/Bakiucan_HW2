//
//  TopStoriesResponse.swift
//
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation

// MARK: - TopStoriesResponse

/// A struct representing the response for the top stories from the NY Times.
public struct TopStoriesResponse: Decodable {
    public let results: [Story]  // An array of stories from the response.

    // MARK: Coding Keys

    private enum RootCodingKeys: String, CodingKey {
        case results    // The coding key for the "results" property in the JSON.
    }

    // MARK: Initialization

    /// Initializes a new instance of the TopStoriesResponse struct.
    ///
    /// - Parameters:
    ///   - decoder: The decoder to use for decoding the JSON.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Story].self, forKey: .results)
    }
}
