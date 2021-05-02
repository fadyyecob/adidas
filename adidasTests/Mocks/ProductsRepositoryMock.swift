//
//  ProductsRepositoryMock.swift
//  adidasTests
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation
@testable import adidas

struct ProductsRepositoryMock: ProductsRepositoryProtocol {
    var cachedProducts: [Product]
    let result: Result<[Product], Error>
    
    func getProducts(_ completion: @escaping ((Result<[Product], Error>) -> Void)) {
        completion(result)
    }
}
