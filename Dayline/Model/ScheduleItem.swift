import Foundation

struct ScheduleItem: Identifiable, Codable, Hashable {
    let id: UUID
    let externalID: String?
    let title: String
    let startDate: Date
    let endDate: Date?
    let location: String?
    let notes: String?
    let isAllDay: Bool

    private var effectiveEndDate: Date {
        endDate ?? startDate.addingTimeInterval(60 * 60)
    }

    var isCurrent: Bool {
        if isAllDay {
            return Calendar.current.isDateInToday(startDate)
        }

        return Date.now >= startDate && Date.now < effectiveEndDate
    }

    var hasPassed: Bool {
        if isAllDay {
            let today = Calendar.current.startOfDay(for: .now)
            let eventDay = Calendar.current.startOfDay(for: startDate)

            return eventDay < today
        }

        return Date.now >= effectiveEndDate
    }

    var isUpcoming: Bool {
        Date.now < startDate
    }

    var detail: String? {
        if let location, !location.isEmpty {
            return location
        }
        if isAllDay {
            return "All day"
        }
        if let endDate {
            let start = startDate.formatted(date: .omitted, time: .shortened)
            let end = endDate.formatted(date: .omitted, time: .shortened)
            return "\(start)–\(end)"
        }
        return nil
    }

    init(
        id: UUID = UUID(),
        externalID: String? = nil,
        title: String,
        startDate: Date,
        endDate: Date? = nil,
        location: String? = nil,
        notes: String? = nil,
        isAllDay: Bool = false
    ) {
        self.id = id
        self.externalID = externalID
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.notes = notes
        self.isAllDay = isAllDay
    }
}

extension ScheduleItem {
    static let sampleItems: [ScheduleItem] = {
        let calendar = Calendar.current
        let today = Date()

        func time(
            hour: Int,
            minute: Int = 0
        ) -> Date {
            calendar.date(
                bySettingHour: hour,
                minute: minute,
                second: 0,
                of: today
            ) ?? today
        }

        return [
            ScheduleItem(
                title: "Morning routine",
                startDate: time(hour: 9),
                endDate: time(hour: 9, minute: 30),
                location: nil
            ),
            ScheduleItem(
                title: "AI class",
                startDate: time(hour: 11),
                endDate: time(hour: 12),
                location: "UNC Charlotte"
            ),
            ScheduleItem(
                title: "Interview",
                startDate: time(hour: 14),
                endDate: time(hour: 15),
                location: "Horizon Media"
            ),
            ScheduleItem(
                title: "Portfolio work",
                startDate: time(hour: 16),
                endDate: time(hour: 17),
                location: nil
            ),
            ScheduleItem(
                title: "Workout",
                startDate: time(hour: 18),
                endDate: time(hour: 19),
                location: nil
            )
        ]
    }()
}
