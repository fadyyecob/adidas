//
//  URLComponents+makeAdidas.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

extension URLComponents {
    static func makeAdidas(path: String) -> Self {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 3001
        urlComponents.path = path
        
        return urlComponents
    }
}
