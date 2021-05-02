//
//  AddProductReviewView.swift
//  adidas
//
//  Created by Fady Yecob on 02/05/2021.
//

import SwiftUI

struct AddProductReviewView: View {
    let viewModel: AddProductReviewViewModel
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var rating = 3
    @State private var text = ""
    @State private var showingAlert = false
    
    init(viewModel: AddProductReviewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Your review", text: $text)
                Picker(selection: $rating, label: Text("Rating")) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }.pickerStyle(SegmentedPickerStyle())
            }
            .navigationTitle("Write a review")
            .navigationBarItems(leading: cancelButton, trailing: postButton)
        }
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var postButton: some View {
        Button("Post") {
            viewModel.post(review: makeReview()) { result in
                switch result {
                case .success:
                    presentationMode.wrappedValue.dismiss()
                case .failure:
                    showingAlert = true
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Review not posted, something went wrong"), dismissButton: .cancel())
        }
    }
    
    private func makeReview() -> Review {
        Review(
            productID: viewModel.productID,
            locale: Locale.current.languageCode ?? "en-US",
            rating: rating,
            text: text
        )
    }
}

struct AddProductReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductReviewView(viewModel: AddProductReviewViewModel(productID: ""))
    }
}
