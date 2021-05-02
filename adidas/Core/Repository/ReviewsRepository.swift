//
//  ReviewsRepository.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation

protocol ReviewsRepositoryProtocol {
    func post(review: Review, _ completion: @escaping ((Result<Bool, Error>) -> Void))
}

class ReviewsRepository: ReviewsRepositoryProtocol {
    private let urlSession: URLSession
    private let path = "/reviews"
    private let port = 3002
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func post(review: Review, _ completion: @escaping ((Result<Bool, Error>) -> Void)) {
        var request = URLRequest.makeAdidas(path: path + "/\(UUID().uuidString)", httpMethod: .post, port: port)
        
        do {
            let reviewData = try JSONEncoder().encode(review)
            request.httpBody = reviewData
        } catch {
            completion(.failure(error))
        }
        
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            completion(.success(true))
        }.resume()
    }
}
