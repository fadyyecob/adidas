//
//  CurrencyFormatter.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import Foundation

class CurrencyFormatter: NumberFormatter {
    init(currency: String) {
        super.init()
        currencySymbol = currency
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
