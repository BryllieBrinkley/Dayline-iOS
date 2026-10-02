import Foundation

enum EditionSectionType: String, Codable, Hashable, CaseIterable {
    case schedule
    case inbox
    case tasks
    case packages
    case weather
    case news
    case crossword

    var title: String {
        switch self {
        case .schedule:
            return "Your Day"
        case .inbox:
            return "Inbox Intelligence"
        case .tasks:
            return "Today's Tasks"
        case .packages:
            return "Packages"
        case .weather:
            return "Today's Weather"
        case .news:
            return "Your World"
        case .crossword:
            return "Mini Crossword"
        }
    }

    var systemImage: String {
        switch self {
        case .schedule:
            return "calendar"
        case .inbox:
            return "envelope"
        case .tasks:
            return "checklist"
        case .packages:
            return "shippingbox"
        case .weather:
            return "cloud.sun"
        case .news:
            return "newspaper"
        case .crossword:
            return "square.grid.3x3"
        }
    }
}
