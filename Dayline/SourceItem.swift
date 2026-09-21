import SwiftUI

struct SourceItem: Identifiable {
    let id = UUID()
    let name: String
    var icon: String
    var connectionStatus: SourceItemConnectionStatus
}

enum SourceItemConnectionStatus {
    case disconnected
    case connected
    case connecting
    case failed
}
