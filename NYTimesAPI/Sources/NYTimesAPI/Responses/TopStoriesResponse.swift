//
//  TopStoriesResponse.swift
//  
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation

public struct TopStoriesResponse: Decodable {
    public let results: [Story]

    private enum RootCodingKeys: String, CodingKey {
        case results
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Story].self, forKey: .results)
    }
}
