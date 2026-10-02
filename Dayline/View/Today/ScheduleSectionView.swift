import SwiftUI
import EventKit

struct ScheduleSectionView: View {
    @State private var scheduleItems: [ScheduleItem] = []
    
    private let calendarService = DayCalendarService()
    
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Your Schedule")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Button("See all") {
                    if let url = URL(string: "calshow://") {
                        openURL(url)
                    }
                }
                .font(.subheadline)
            }
            .padding(.bottom, 6)

            Divider()

            ForEach(Array(scheduleItems.enumerated()), id: \.element.id) { entry in
                let index = entry.offset
                let item = entry.element

                ScheduleRowView(
                    item: item,
                    isFirst: index == 0,
                    isLast: index == scheduleItems.count - 1
                )
            }
        }
        .task {
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
}
