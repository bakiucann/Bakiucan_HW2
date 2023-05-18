//
//  NYTimesService.swift
//  
//
//  Created by Baki Uçan on 12.05.2023.
//

import Foundation
import Alamofire

public protocol NYTimesServiceProtocol: AnyObject {
    func fetchTopStories(completion: @escaping (Result<[Story], Error>) -> Void)
}

public class NYTimesService: NYTimesServiceProtocol {

    private let apiKey = "FLFxlV5BQManpQovxyZKBEI9VaksP5OJ"

    public init() {}

    public func fetchTopStories(completion: @escaping (Result<[Story], Error>) -> Void) {

        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)"
        AF.request(urlString).responseData { response in
            switch response.result {

            case .success(let data):
                let decoder = Decoders.dateDecoder

                do {
                    let response = try decoder.decode(TopStoriesResult.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("********** JSON DECODE ERROR *******")
                }
            case .failure(let error):
                print("**** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription) ******")
            }
        }

    }
}
