import Foundation
import Combine

final class CustomizeViewModel: ObservableObject {
    @Published var sections: [DailySection] =
    
    [
        DailySection(title: "Weather", iconName: "sun.max"),
        DailySection(title: "Calendar", iconName: "calendar"),
        DailySection(title: "Top 3", iconName: "list.bullet"),
        DailySection(title: "Inbox Brief", iconName: "envelope"),
        DailySection(title: "Package Tracking", iconName: "shippingbox"),
        DailySection(title: "Personalized News", iconName: "newspaper"),
        DailySection(title: "Daily Comiic", iconName: "face.smiling"),
        DailySection(title: "Mini Crossword", iconName: "gamecontroller"),
    
    ]
    
}
