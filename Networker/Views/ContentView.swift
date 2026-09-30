/// Sample code from the book, Expert Swift,
/// published at kodeco.com, Copyright (c) 2025 Kodeco Inc.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.kodeco.com/books/expert-swift

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ArticlesViewModel(networker: Networker())

    var body: some View {
        TabView {
            Tab("All Articles", systemImage: "newspaper") {
                NavigationStack {
                    ArticlesView(viewModel: viewModel)
                }
            }
            Tab("Read Later", systemImage: "bookmark") {
                NavigationStack {
                    ReadLaterView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
