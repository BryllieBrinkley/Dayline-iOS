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
            headline: "Small steps create momentum for meaningful progress",
            imageName: "nature"
        ),
        
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -2,
                to: .now
            ) ?? .now,
            readTime: 8,
            headline: "How AI is reshaping the future of creative work",
            imageName: "laptop-morning"
        ),
        
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -3,
                to: .now
            ) ?? .now,
            readTime: 7,
            headline: "A clearer schedule starts with the right priorities",
            imageName: "skyline"
        ),
        
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -4,
                to: .now
            ) ?? .now,
            readTime: 7,
            headline: "Your week ahead: key events, tasks, and opportunities",
            imageName: "agenda"
        ),
        
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -5,
                to: .now
            ) ?? .now,
            readTime: 7,
            headline: "The stories and updates shaping your day",
            imageName: "newspaper"
        ),
        
        Edition(
            date: Calendar.current.date(
                byAdding: .day,
                value: -6,
                to: .now
            ) ?? .now,
            readTime: 7,
            headline: "Protect your energy and focus on what matters",
            imageName: "nature"
        )
    ]
}
