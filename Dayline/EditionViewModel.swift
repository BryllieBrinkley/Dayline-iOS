import Foundation
import Combine


@MainActor
@Observable
final class EditionViewModel: ObservableObject {
    
    func fetchQuotes() async throws -> Quote {
        let endpoint = "https://zenquotes.io/api/today"
        guard let url = URL(string: endpoint) else {
            throw QuoteError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw QuoteError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode([Quote].self, from: data)
            
            guard let quote = response.first else {
                throw QuoteError.invalidData
            }
            return quote
        } catch {
            throw QuoteError.invalidData
        }
    }

    func fetchNews() async throws -> NewsArticle {
        
        guard let storedKey = Bundle.main.object(
            forInfoDictionaryKey: "GNEWS_API_KEY"
        ) as? String else {
            throw NewsError.missingAPIKey
        }

        let apiKey = storedKey.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !apiKey.isEmpty else {
            throw NewsError.missingAPIKey
        }
        
        let endpoint = "https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&apikey=\(apiKey)"
        print(endpoint)

        guard let url = URL(string: endpoint) else {
            throw NewsError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            print("GNews error:", String(decoding: data, as: UTF8.self))
            throw NewsError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            let news = try decoder.decode(News.self, from: data)

            guard let article = news.articles.first else {
                throw NewsError.invalidData
            }

            return article
        } catch {
            throw NewsError.invalidData
        }
    }
    
}
