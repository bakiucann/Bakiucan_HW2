//
//  NetworkManager.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import Foundation
import NYTimesAPI

enum NetworkError: Error {
    case noData
    case decodingError
}

class NetworkManager {

    private let service: NYTimesServiceProtocol

    init(service: NYTimesServiceProtocol = NYTimesService()) {
        self.service = service
    }

    func getTopStories(completion: @escaping (Result<[Story], NetworkError>) -> Void) {
        service.fetchTopStories { result in
            switch result {
            case .success(let stories):
                completion(.success(stories))
            case .failure(_):
                completion(.failure(.noData))
            }
        }
    }
}


