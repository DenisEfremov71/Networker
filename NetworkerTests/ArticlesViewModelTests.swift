/// Sample code from the book, Expert Swift,
/// published at kodeco.com, Copyright (c) 2022 Kodeco LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.kodeco.com/books/expert-swift

import Combine
import XCTest

@testable import Networker

struct MockNetworker: Networking {
    weak var delegate: NetworkingDelegate?
    
    func fetch(_ request: Request) async throws -> Data {
        switch request {
        case is ArticleRequest:
            return try articlesData()
        default:
            return Data()
        }
    }

    func fetch<T: Decodable>(url: URL) async throws -> T {
        try JSONDecoder().decode(T.self, from: articlesData())
    }

    private func articlesData() throws -> Data {
        let article = Article(
            name: "Article Name",
            description: "Article Description",
            image: URL(string: "https://image.com")!,
            id: "Article ID",
            downloadedImage: nil
        )
        let articleData = ArticleData(article: article)
        let articles = Articles(data: [articleData])
        return try JSONEncoder().encode(articles)
    }
}

@MainActor
class ArticlesViewModelTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: ArticlesViewModel!

    override func setUp() async throws {
        try await super.setUp()
        viewModel = ArticlesViewModel(networker: MockNetworker())
    }

    override func tearDown() async throws {
        try await super.tearDown()
    }

    func testArticlesAreFetchedCorrectly() async {
        XCTAssert(viewModel.articles.isEmpty)
        await viewModel.fetchArticles()
        XCTAssertEqual(viewModel.articles[0].id, "Article ID")
    }
}
