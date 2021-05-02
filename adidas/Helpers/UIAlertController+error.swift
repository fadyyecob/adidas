//
//  UIAlertController+error.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import UIKit

extension UIAlertController {
    static func make(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        return alert
    }
}
