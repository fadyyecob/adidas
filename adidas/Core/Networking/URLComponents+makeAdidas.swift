//
//  URLComponents+makeAdidas.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

extension URLComponents {
    static func makeAdidas(path: String, port: Int?) -> Self {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = port
        urlComponents.path = path
        
        return urlComponents
    }
}
