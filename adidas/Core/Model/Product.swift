//
//  Product.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

struct Product: Decodable {
    let currency: String
    let price: Decimal
    let id: String
    let name: String
    let description: String
    let imageURL: URL
    
    let reviews: [Review]
}

private extension Product {
    enum CodingKeys: String, CodingKey {
        case currency
        case price
        case id
        case name
        case description
        case imageURL = "imgUrl"
        case reviews
    }
}
