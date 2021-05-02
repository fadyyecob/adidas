//
//  AddProductReviewViewModel.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation

struct AddProductReviewViewModel {
    private let reviewsRepository: ReviewsRepositoryProtocol
    let productID: String
    
    init(
        productID: String,
        reviewsRepository: ReviewsRepositoryProtocol = ReviewsRepository()
    ) {
        self.productID = productID
        self.reviewsRepository = reviewsRepository
    }
    
    func post(review: Review, _ completion: @escaping ((Result<Bool, Error>) -> Void)) {
        reviewsRepository.post(review: review, completion)
    }
}
