//
//  ProductDetailsView.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import SwiftUI

struct ProductDetailsView: View {
    let viewModel: ProductDetailsViewModel
    @State private var image = UIImage()
    @State private var finishedLoading = false
    
    var body: some View {
        ScrollView {
            VStack {
                productImageView
                productCurrencyAndPriceView
                productDescriptionView
                ProductReviewsView(viewModel: viewModel.productReviewViewModel)
                Spacer()
            }
        }.navigationTitle(viewModel.productName)
    }
    
    private var productImageView: some View {
        ZStack {
            progressView
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onReceive(viewModel.imageLoader.didChange) { data in
                    image = UIImage(data: data) ?? UIImage()
                    finishedLoading = true
                }
        }
    }
    
    private var productCurrencyAndPriceView: some View {
        HStack {
            Text(viewModel.currencyAndPrice)
                .padding([.leading, .trailing])
            Spacer()
        }
    }
    
    private var productDescriptionView: some View {
        HStack {
            Text(viewModel.description)
                .padding([.leading, .trailing])
            Spacer()
        }
    }
    
    private var progressView: some View {
        if !finishedLoading {
            return AnyView(EmptyView())
        } else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            )
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(
            viewModel: ProductDetailsViewModel(
                product: Product(currency: "$", price: 34.34, id: "id", name: "name", description: "description", imageURL: URL(fileURLWithPath: ""), reviews: [])
            )
        )
    }
}
