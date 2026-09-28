/// Sample code from the book, Expert Swift,
/// published at kodeco.com, Copyright (c) 2025 Kodeco Inc.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.kodeco.com/books/expert-swift

import SwiftUI

struct ArticleRow: View {
    let article: Article
    let image: Binding<UIImage?>

    var body: some View {
        HStack(alignment: .top) {
            if let image = article.downloadedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 85, height: 85)
                    .cornerRadius(16)
            } else {
                placeholder
            }
            VStack(alignment: .leading) {
                Text(article.name).bold()
                Text(article.description)
            }
            .padding(.top, 3)
        }
        .frame(height: 100)
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(
                    colors: [.indigo, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 85, height: 85)
            .overlay {
                if article.image != nil {
                    // Artwork exists but is still downloading.
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "doc.text.image")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
    }
}

#Preview {
    ArticleRow(article: Article.preview, image: .constant(nil))
}

#Preview("No artwork") {
    ArticleRow(
        article: Article(
            name: "Kodebits Day 97: Enumerated Loop",
            description: "Practice loops with a short swift challenge.",
            image: nil,
            id: "1"
        ),
        image: .constant(nil)
    )
}
