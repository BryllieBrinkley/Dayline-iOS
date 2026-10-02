import Foundation
import SwiftData

@Model
final class SavedEdition {
    var createdAt: Date
    var headline: String
    var articleSummary: String
    var articleURL: String?
    var quoteText: String
    var quoteAuthor: String

    init(
        headline: String,
        articleSummary: String,
        articleURL: String?,
        quoteText: String,
        quoteAuthor: String
    ) {
        self.createdAt = .now
        self.headline = headline
        self.articleSummary = articleSummary
        self.articleURL = articleURL
        self.quoteText = quoteText
        self.quoteAuthor = quoteAuthor
    }
}
