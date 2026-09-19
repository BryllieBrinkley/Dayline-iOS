import Foundation
import SwiftUI
import Combine


struct Edition: Identifiable {
    let id = UUID()
    let date: Date
    let readTime: Int
    let headline: String
    let imageName: String
}
extension Edition {

    static let sampleEditions: [Edition] = [
        Edition(
            date: .now,
            readTime: 7,
            headline: "Preparation today creates tomorrow’s opportunities",
            imageName: "skyline"
        ),
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -1,
                to: .now
            ) ?? .now,
            readTime: 6,
            headline: "Small steps, big progress in a changing world",
            imageName: "nature",
        ),
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -2,
                to: .now
            ) ?? .now,
            readTime: 8,
            headline: "How AI is reshaping creative work",
            imageName: "laptop-morning"
        )
    ]
}
