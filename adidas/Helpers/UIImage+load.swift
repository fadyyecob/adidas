//
//  UIImage+load.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import UIKit

extension UIImage {
    static func load(fromURL url: URL, completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                return completion(nil)
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
    }
}
