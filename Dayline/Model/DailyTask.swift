import Foundation

struct DailyTask: Identifiable, Codable, Hashable {
    let id: UUID
    let externalID: String?
    let title: String
    let notes: String?
    let dueDate: Date?
    var isCompleted: Bool
    let priority: DailyTaskPriority

    init(
        id: UUID = UUID(),
        externalID: String? = nil,
        title: String,
        notes: String? = nil,
        dueDate: Date? = nil,
        isCompleted: Bool = false,
        priority: DailyTaskPriority = .normal
    ) {
        self.id = id
        self.externalID = externalID
        self.title = title
        self.notes = notes
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.priority = priority
    }
}

enum DailyTaskPriority: String, Codable, Hashable {
    case low
    case normal
    case high
}
