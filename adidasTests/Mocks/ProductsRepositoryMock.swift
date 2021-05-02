//
//  ProductsRepositoryMock.swift
//  adidasTests
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation
@testable import adidas

class ProductsRepositoryMock: ProductsRepositoryProtocol {
    var cachedProducts: [Product] = []
    let result: Result<[Product], Error>
    
    init(cachedProducts: [Product] = [], result: Result<[Product], Error>) {
        self.cachedProducts = cachedProducts
        self.result = result
    }
    
    func getProducts(_ completion: @escaping ((Result<[Product], Error>) -> Void)) {
        switch result {
        case .success(let products):
            cachedProducts = products
        default:
            break
        }
        completion(result)
    }
}
