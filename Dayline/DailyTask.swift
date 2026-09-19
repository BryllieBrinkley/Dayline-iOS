import Foundation

struct DailyTask: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool = false
}
