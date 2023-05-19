//
//  NYTimesService.swift
//
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation
import Alamofire

// MARK: - NYTimesServiceProtocol

/// A protocol defining the methods for fetching top stories from the NY Times service.
public protocol NYTimesServiceProtocol: AnyObject {
    func fetchTopStories(completion: @escaping (Result<[Story], Error>) -> Void)
}

// MARK: - NYTimesService

/// A class that implements the NYTimesServiceProtocol for fetching top stories from the NY Times service.
public class NYTimesService: NYTimesServiceProtocol {

    private let apiKey = "FLFxlV5BQManpQovxyZKBEI9VaksP5OJ"   // The API key for accessing the NY Times service.

    /// Initializes a new instance of the NYTimesService class.
    public init() {}

    /// Fetches the top stories from the NY Times service.
    ///
    /// - Parameter completion: A closure to be called with the result of the fetch operation.
    public func fetchTopStories(completion: @escaping (Result<[Story], Error>) -> Void) {

        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)"

        // Send a request to the NY Times API using Alamofire
        AF.request(urlString).responseData { response in
            switch response.result {

            case .success(let data):
                let decoder = Decoders.dateDecoder

                do {
                    let response = try decoder.decode(TopStoriesResult.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("********** JSON DECODE ERROR *******")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("**** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription) ******")
                completion(.failure(error))
            }
        }
    }
}
