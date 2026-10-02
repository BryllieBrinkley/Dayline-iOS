import Foundation

struct OnboardingSourceItem: Identifiable, Codable, Hashable {
    var id: OnboardingSourceType {
        type
    }

    let type: OnboardingSourceType
    var isSelected: Bool

    init(
        type: OnboardingSourceType,
        isSelected: Bool = false
    ) {
        self.type = type
        self.isSelected = isSelected
    }
}
extension OnboardingSourceItem {
    static let defaults = OnboardingSourceType.allCases.map {
        OnboardingSourceItem(type: $0)
    }
}

    
enum OnboardingSourceType: String, Codable, Hashable, CaseIterable {

        case googleCalendar = "Google Calendar"
        case outlookCalendar = "Outlook Calendar"
        case gmail = "Gmail"
        case outlookMail = "Outlook Mail"
        case slack = "Slack"
        case notion = "Notion"
        case googleDrive = "Google Drive"
        case appleCalendar = "Apple Calendar"
        case reminders = "Reminders"
        case weather = "Weather"
        case news = "News"
        case packages = "Packages"
        case markets = "Markets"
        case healthFitness = "Health & Fitness"

        var title: String {
            rawValue
        }

        var icon: SourceIcon {
            switch self {
            case .googleCalendar:
                return .asset("google-calendar-logo")

            case .outlookCalendar:
                return .asset("outlook-calendar-logo")

            case .gmail:
                return .asset("gmail-logo")

            case .outlookMail:
                return .asset("outlook-mail-logo")

            case .slack:
                return .asset("slack-logo")

            case .notion:
                return .asset("notion-icon")

            case .googleDrive:
                return .asset("google-drive-logo")

            case .appleCalendar:
                return .system("calendar")

            case .reminders:
                return .system("checklist")

            case .weather:
                return .system("cloud.sun")

            case .news:
                return .system("newspaper")

            case .packages:
                return .system("shippingbox")

            case .markets:
                return .system("chart.line.uptrend.xyaxis")

            case .healthFitness:
                return .system("heart")
            }
        }

        var defaultConnectionStatus: ConnectionStatus {
            switch self {
            case .googleCalendar,
                 .outlookCalendar,
                 .outlookMail,
                 .slack,
                 .notion,
                 .appleCalendar,
                 .reminders,
                 .weather,
                 .packages:
                return .connected

            case .gmail,
                 .googleDrive,
                 .news,
                 .markets,
                 .healthFitness:
                return .disconnected
        }
    }
}

enum SourceIcon {
            case asset(String)
            case system(String)
        }
