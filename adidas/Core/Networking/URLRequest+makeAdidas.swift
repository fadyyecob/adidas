//
//  URLRequest+makeAdidas.swift
//  adidas
//
//  Created by Fady Yecob on 01/05/2021.
//

import Foundation

extension URLRequest {
    static func makeAdidas(path: String, httpMethod: HTTPMethod = .get) -> Self {
        let urlComponents = URLComponents.makeAdidas(path: path)
        
        var urlRequest = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
}
