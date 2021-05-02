//
//  ProductListItemViewModel.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

struct ProductListItemViewModel: Hashable {
    private let uuid = UUID()
    let id: String
    let name: String
    let imageURL: URL
    let description: String
    let currencyAndPrice: String
    
    var descriptionAndPrice: String {
        [description, currencyAndPrice]
            .joined(separator: "\n")
    }
    
    init(product: Product) {
        id = product.id
        name = product.name
        imageURL = product.imageURL
        description = product.description
        currencyAndPrice = Self.makeCurrencyAndPriceString(currency: product.currency, price: product.price)
    }
    
    private static func makeCurrencyAndPriceString(currency: String, price: Decimal) -> String {
        let formatter = CurrencyFormatter(currency: currency)
        return formatter.string(from: NSDecimalNumber(decimal: price)) ?? ""
    }
}
