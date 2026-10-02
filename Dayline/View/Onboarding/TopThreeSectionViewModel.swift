import Foundation
import Combine

final class TopThreeSectionViewModel: ObservableObject {
    @Published var tasks: [DailyTask]

    init(tasks: [DailyTask] = [
        DailyTask(title: "Work on portfolio"),
        DailyTask(title: "HW for Math"),
        DailyTask(title: "Workout with Coach")
    ]) {
        self.tasks = tasks
    }

    @discardableResult
    func addTask(title rawTitle: String) -> Bool {
        let title = rawTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return false }
        tasks.append(DailyTask(title: title))
        return true
    }
}
