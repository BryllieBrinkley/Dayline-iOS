import Foundation

struct DailySection: Identifiable, Codable, Hashable {
    var id: EditionSectionType { type }

    let type: EditionSectionType
    var isEnabled: Bool
    var position: Int

    init(
        type: EditionSectionType,
        isEnabled: Bool = true,
        position: Int
    ) {
        self.type = type
        self.isEnabled = isEnabled
        self.position = position
    }
}

extension DailySection {
    static let defaults: [DailySection] = [
        DailySection(type: .schedule, position: 0),
        DailySection(type: .inbox, position: 1),
        DailySection(type: .tasks, position: 2),
        DailySection(type: .packages, position: 3),
        DailySection(type: .weather, position: 4),
        DailySection(type: .news, position: 5),
        DailySection(type: .crossword, position: 6)
    ]

    var title: String {
        type.title
    }

    var iconName: String {
        type.systemImage
    }
}
