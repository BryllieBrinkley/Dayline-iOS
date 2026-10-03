import Foundation
import Combine
import EventKit


@MainActor
final class EditionViewModel: ObservableObject {
    
    // Published state owned by the ViewModel
    @Published var quote: Quote?
    @Published var articles: [NewsArticle] = []
    @Published var events: [EKEvent] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Services
    private let calendarService = DayCalendarService()
    
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
    
    func fetchNews() async throws -> [NewsArticle] {
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
            return Array(news.articles.prefix(3))
        } catch {
            throw NewsError.invalidData
        }
    }

    
    
    func fetchComic() async throws -> Comic {

        let url = URL(string: "https://xkcd.com/info.0.json")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let comic = try JSONDecoder().decode(Comic.self, from: data)
        
        return comic
        
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        async let newsResult: [NewsArticle]? = try? fetchNews()
        async let quoteResult: Quote? = try? fetchQuotes()
        async let eventsResult: [EKEvent]? = try? calendarService.fetchEvents()

        let (articles, q, evts) = await (
            newsResult,
            quoteResult,
            eventsResult
        )

        if let articles {
            self.articles = articles
        }

        if let q {
            self.quote = q
        }

        if let evts {
            self.events = evts
        }
    }
}
