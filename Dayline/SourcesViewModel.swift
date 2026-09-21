import Foundation
import Observation

@MainActor
@Observable
final class SourcesViewModel {
    
    var sources: [SourceItem] =
    
    [
        SourceItem(name: "Google Calendar", icon: "google-calendar-logo", connectionStatus: .connected),
        SourceItem(name: "Outlook Calendar", icon: "outlook-calendar-logo", connectionStatus: .connected),
        SourceItem(name: "Gmail", icon: "gmail-logo", connectionStatus: .disconnected),
        SourceItem(name: "Outlook Mail", icon: "outlook-mail-logo", connectionStatus: .connected),
        SourceItem(name: "Slack", icon: "slack-logo", connectionStatus: .connected),
        SourceItem(name: "Notion", icon: "notion-icon", connectionStatus: .connected),
        SourceItem(name: "Google Drive", icon: "google-drive-logo", connectionStatus: .disconnected),
        SourceItem(name: "Apple Calendar", icon: "calendar", connectionStatus: .connected),
        SourceItem(name: "Reminders", icon: "checklist", connectionStatus: .connected),
        SourceItem(name: "Weather", icon: "cloud.sun", connectionStatus: .connected),
        SourceItem(name: "News", icon: "newspaper", connectionStatus: .disconnected),
        SourceItem(name: "Packages", icon: "shippingbox", connectionStatus: .connected),
        SourceItem(name: "Markets", icon: "chart.line.uptrend.xyaxis", connectionStatus: .disconnected),
        SourceItem(name: "Health & Fitness", icon: "heart", connectionStatus: .disconnected)
    ]

    var editionTime = "7:00 AM"
    
    
}

