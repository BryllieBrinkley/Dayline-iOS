import Foundation

enum QuoteError: Error {
    case invalidURL, invalidResponse, invalidData
}

enum NewsError: Error {
    case invalidURL, invalidResponse, invalidData, missingAPIKey
}

enum ComicError: Error {
    case invalidURL, invalidResponse, invalidData, missingAPIKey
}
