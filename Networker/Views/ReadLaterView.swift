/// Sample code from the book, Expert Swift,
/// published at kodeco.com, Copyright (c) 2025 Kodeco Inc.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.kodeco.com/books/expert-swift

import SwiftUI

struct ReadLaterView: View {
    let viewModel: ArticlesViewModel

    var body: some View {
        List(viewModel.savedArticles) { article in
            ArticleRow(article: article, image: .constant(nil))
                .task { await viewModel.fetchImage(for: article) }
        }
        .overlay {
            if viewModel.savedArticles.isEmpty {
                ContentUnavailableView(
                    "No Saved Articles",
                    systemImage: "bookmark",
                    description: Text("Swipe an article to save it for later.")
                )
            }
        }
        .navigationTitle("Read Later")
    }
}

#Preview {
    NavigationStack {
        ReadLaterView(viewModel: ArticlesViewModel(networker: Networker()))
    }
}
