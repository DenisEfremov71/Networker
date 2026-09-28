/// Sample code from the book, Expert Swift,
/// published at kodeco.com, Copyright (c) 2022 Kodeco LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.kodeco.com/books/expert-swift

import Combine
import Playgrounds
import SwiftUI

@MainActor
@Observable class ArticlesViewModel {
    private(set) var articles: [Article] = []
    private var networker: Networking

    init(networker: Networking) {
        self.networker = networker
        self.networker.delegate = self
    }

    func fetchArticles() async {
        let baseURL = "https://api.kodeco.com/api"
        let path = "/contents?filter[content_types][]=article"
        let url = URL(string: baseURL + path)!

        do {
            let articlesData: Articles = try await networker.fetch(url: url)
            articles = articlesData.data.map { $0.article }
        } catch {
            articles = []
        }
    }

    func fetchImage(for article: Article) async {
        guard article.downloadedImage == nil,
            let articleIndex = articles.firstIndex(where: {
                $0.id == article.id
            }),
            let imageURL = article.image
        else {
            return
        }

        let request = ImageRequest(url: imageURL)
        guard let data = try? await networker.fetch(request) else {
            return
        }
        articles[articleIndex].downloadedImage = UIImage(data: data)
    }
}

extension ArticlesViewModel: NetworkingDelegate {
    nonisolated func headers(for networking: Networking) -> [String: String] {
        return ["Content-Type": "application/vnd.api+json; charset=utf-8"]
    }

    nonisolated func networking(
        _ networking: Networking,
        didReceive response: URLResponse
    ) {
        print("Received response:")
        print(response)
    }
}
