import Foundation
import EventKit

@MainActor
final class DayCalendarService {
    private let store  = EKEventStore()
    
    
    func fetchEvents() async throws -> [EKEvent] {
        
        let permissionAccess = try await store.requestFullAccessToEvents()
        
        guard permissionAccess else { return [] }
        
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: .now)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        
        let predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)
        
        return store.events(matching: predicate)
            .sorted { $0.startDate < $1.startDate }
    }
}
