//
//  ImageLoader.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import SwiftUI
import Combine

// Copied from https://stackoverflow.com/questions/60677622/how-to-display-image-from-a-url-in-swiftui with slight modifications
class ImageLoader: ObservableObject {
    private(set) var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
