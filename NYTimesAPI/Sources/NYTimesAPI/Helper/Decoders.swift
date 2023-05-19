//
//  Decoders.swift
//
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation

// MARK: - Decoders

/// A utility class that provides custom JSON decoders.
public enum Decoders {
    /// The JSON decoder for decoding dates.
    static let dateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()

        // Create a date formatter with the specified format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        // Set the date decoding strategy to use the custom date formatter
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return decoder
    }()
}
