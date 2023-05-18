//
//  NYTimes.swift
//  
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation

public struct Story: Decodable {
    public let id: Int?
    public let title: String?
    public let abstract: String?
    public let url: String?
    public let byline: String?
    public let item_type: String?
    public let updated_date: Date?
    public let created_date: Date?
    public let published_date: Date?
    public let material_type_facet: String?
    public let kicker: String?
    public let multimedia: [Multimedia]?

    public var thumbnailURL: String? {
        return multimedia?.first(where: { $0.format == "Large Thumbnail" })?.url
    }

    public var largeImageURL: String? {
        return multimedia?.first(where: { $0.format == "Super Jumbo" })?.url
    }
}

public struct Multimedia: Decodable {
    public let url: String
    public let format: String
}
public struct TopStoriesResult: Decodable {
    public let results: [Story]
}
