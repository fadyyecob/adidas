//
//  ProductListViewModel.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

struct ProductListViewModel {
    private let productsRepository: ProductsRepositoryProtocol
    private var cachedProducts: [ProductListItemViewModel] {
        productsRepository.cachedProducts.map { ProductListItemViewModel(product: $0) }
    }
    
    let title = "All Products"
    
    init(productsRepository: ProductsRepositoryProtocol = ProductsRepository()) {
        self.productsRepository = productsRepository
    }
    
    func getProducts(_ completion: @escaping ((Result<[ProductListItemViewModel], Error>) -> Void)) {
        productsRepository.getProducts { result in
            switch result {
            case .success(let products):
                let productListItemViewModels = products.map {
                    ProductListItemViewModel(product: $0)
                }
                completion(.success(productListItemViewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filteredCachedProducts(using text: String?) -> [ProductListItemViewModel] {
        guard let text = text?.lowercased(), !text.isEmpty else {
            return cachedProducts
        }
        
        return cachedProducts.filter {
            $0.description.lowercased().contains(text) || $0.name.lowercased().contains(text)
        }
    }
    
    func productDetailsViewModel(atRow row: Int, searchText: String?) -> ProductDetailsViewModel? {
        let productListItemViewModel = filteredCachedProducts(using: searchText)[row]
        
        guard let product = productsRepository.cachedProducts.first(where: { $0.id == productListItemViewModel.id }) else {
            return nil
        }
        
        return ProductDetailsViewModel(product: product)
    }
}
