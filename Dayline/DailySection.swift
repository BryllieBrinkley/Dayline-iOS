import Foundation
import SwiftUI

struct DailySection: Identifiable, Codable {
    let id: UUID
    let title: String
    let iconName: String
    var isEnabled: Bool

    init(
        id: UUID = UUID(),
        title: String,
        iconName: String,
        isEnabled: Bool = true
    ) {
        self.id = id
        self.title = title
        self.iconName = iconName
        self.isEnabled = isEnabled
    }
}
