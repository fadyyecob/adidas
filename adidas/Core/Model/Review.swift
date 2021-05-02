//
//  Review.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

struct Review: Decodable {
    let productID: String
    let locale: String
    let rating: Int
    let text: String
}

private extension Review {
    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case locale
        case rating
        case text
    }
}
