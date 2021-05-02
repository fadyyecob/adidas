//
//  ProductDetailsViewController.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import UIKit
import SwiftUI

class ProductDetailsViewController: UIHostingController<ProductDetailsView> {
    init(viewModel: ProductDetailsViewModel) {
        super.init(rootView: ProductDetailsView(viewModel: viewModel))
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
