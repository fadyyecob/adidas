//
//  ProductsRepository.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

protocol ProductsRepositoryProtocol {
    var cachedProducts: [Product] { get }
    func getProducts(_ completion: @escaping ((Result<[Product], Error>) -> Void))
}

class ProductsRepository: ProductsRepositoryProtocol {
    private let urlSession: URLSessionProtocol
    private let path = "/product"
    
    private(set) var cachedProducts: [Product] = []
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getProducts(_ completion: @escaping ((Result<[Product], Error>) -> Void)) {
        let request = URLRequest.makeAdidas(path: path)
        urlSession.dataTask(request, decode: [Product].self) { [weak self] result in
            switch result {
            case .success(let products):
                self?.cachedProducts = products
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
