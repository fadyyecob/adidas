//
//  ProductReviewsView.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import SwiftUI

struct ProductReviewsView: View {
    let viewModel: ProductReviewsViewModel
    
    var body: some View {
        VStack {
            ForEach(0 ..< viewModel.itemViewModels.count) { index in
                makeReviewItemView(viewModel: viewModel.itemViewModels[index])
            }
        }
    }
    
    private func makeReviewItemView(viewModel: ProductReviewItemViewModel) -> some View {
        VStack {
            Divider()
                .padding(.leading)
            HStack {
                Text(viewModel.text)
                Spacer()
                Text(viewModel.ratingText)
            }.padding([.leading, .trailing])
        }
    }
}

struct ProductReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductReviewsView(viewModel: ProductReviewsViewModel(itemViewModels: []))
    }
}
