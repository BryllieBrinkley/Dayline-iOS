import Foundation
import Combine

final class PastEditionsViewModel: ObservableObject {
    
    @Published var selectedDate: Date = .now
    @Published var selectedEdition: Edition?

    // In a real app, this would be loaded from persistence or a service.
    let editions: [Edition] = Edition.sampleEditions

    var weekDates: [Date] {
        let calendar = Calendar.current
        guard let week = calendar.dateInterval(of: .weekOfYear, for: selectedDate) else {
            return []
        }
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: week.start)
        }
    }
}
