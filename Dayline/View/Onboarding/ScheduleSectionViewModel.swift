import Foundation
import EventKit
import Combine

@MainActor
final class ScheduleSectionViewModel: ObservableObject {
    @Published var scheduleItems: [ScheduleItem] = []
    private let calendarService = DayCalendarService()

    func load() async {
        do {
            let events = try await calendarService.fetchEvents()
            scheduleItems = events.map { event in
                ScheduleItem(
                    externalID: event.eventIdentifier,
                    title: event.title ?? "Untitled event",
                    startDate: event.startDate,
                    endDate: event.endDate,
                    location: event.location,
                    notes: event.notes,
                    isAllDay: event.isAllDay
                )
            }
        } catch {
            print("Calendar fetch failed:", error)
        }
    }
}
