//
//  ProductListViewModelTests.swift
//  adidasTests
//
//  Created by Fady Yecob on 02/05/2021.
//

import XCTest
@testable import adidas

class ProductListViewModelTests: XCTestCase {
    private var productListViewModel: ProductListViewModel!

    override func setUpWithError() throws {
        productListViewModel = ProductListViewModel(productsRepository: ProductsRepositoryMock(result: .success([])))
    }

    override func tearDownWithError() throws {
        productListViewModel = nil
    }
    
    // MARK: - Tests
    
    func testSuccessFulSearch() {
        let products: [Product] = [
            .make(name: "First name", description: "First description"),
            .make(name: "Second name", description: "Second description")
        ]
        let allProducts = products.map { ProductListItemViewModel(product: $0)}
        productListViewModel = ProductListViewModel(productsRepository: ProductsRepositoryMock(result: .success(products)))
        
        getProducts()
        
        let filteredProductsByName = productListViewModel.filteredCachedProducts(using: "OND NA")
        XCTAssertEqual(filteredProductsByName.map(\.name), allProducts.suffix(1).map(\.name))
        
        let filteredProductsByDescription = productListViewModel.filteredCachedProducts(using: "first des")
        XCTAssertEqual(filteredProductsByDescription.map(\.name), Array(allProducts.prefix(1)).map(\.name))
    }
    
    func testUnsuccessFulSearch() {
        let products: [Product] = [
            .make(name: "First name", description: "First description"),
            .make(name: "Second name", description: "Second description")
        ]
        productListViewModel = ProductListViewModel(productsRepository: ProductsRepositoryMock(result: .success(products)))
        
        getProducts()
        
        let filteredProducts = productListViewModel.filteredCachedProducts(using: "bla")
        XCTAssertEqual(filteredProducts, [])
    }

    func testIfSearchIsEmptyReturnAllProducts() {
        let products: [Product] = [.make(), .make()]
        let allProducts = products.map { ProductListItemViewModel(product: $0)}
        productListViewModel = ProductListViewModel(productsRepository: ProductsRepositoryMock(result: .success(products)))
        
        getProducts()
        
        let filteredProductsByEmptyString = productListViewModel.filteredCachedProducts(using: "")
        XCTAssertEqual(allProducts.map(\.name), filteredProductsByEmptyString.map(\.name))
        
        let filteredProductsByNilString = productListViewModel.filteredCachedProducts(using: nil)
        XCTAssertEqual(allProducts.map(\.name), filteredProductsByNilString.map(\.name))
    }
    
    // MARK: - Helpers
    
    private func getProducts() {
        let expectation = XCTestExpectation()
        productListViewModel.getProducts { _ in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
