//
//  Product+Mock.swift
//  adidasTests
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation
@testable import adidas

extension Product {
    static func make(
        currency: String = "$",
        price: Decimal = 69.69,
        id: String = "AB12CD",
        name: String = "Product Name",
        description: String = "Product Description",
        imageURL: URL = URL(string: "www.apple.com") ?? URL(fileURLWithPath: ""),
        reviews: [Review] = []
    ) -> Self {
        Product(currency: currency, price: price, id: id, name: name, description: description, imageURL: imageURL, reviews: reviews)
    }
}
