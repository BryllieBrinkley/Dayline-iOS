import Foundation

struct News: Codable {
    let articles: [NewsArticle]
}
struct NewsArticle: Codable, Identifiable {
    let id = UUID()
    let title: String?
    let description: String?
    let content: String?
    let url: String?
    let image: String?
    
}
