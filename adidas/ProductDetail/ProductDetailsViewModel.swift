//
//  ProductDetailsViewModel.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import UIKit
import SwiftUI

class ProductDetailsViewModel {
    let productName: String
    let currencyAndPrice: String
    let description: String
    let productReviewViewModel: ProductReviewsViewModel
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(product: Product) {        
        productName = product.name
        imageLoader = ImageLoader(url: product.imageURL)
        currencyAndPrice = CurrencyFormatter(currency: product.currency).string(from: NSDecimalNumber(decimal: product.price)) ?? ""
        description = product.description
        productReviewViewModel = Self.makeReviewsViewModel(reviews: product.reviews)
    }
    
    private static func makeReviewsViewModel(reviews: [Review]) -> ProductReviewsViewModel {
        let reviewItemViewModels = reviews.map {
            ProductReviewItemViewModel(text: $0.text, ratingText: "\($0.rating)/5")
        }
        
        return ProductReviewsViewModel(itemViewModels: reviewItemViewModels)
    }
}
