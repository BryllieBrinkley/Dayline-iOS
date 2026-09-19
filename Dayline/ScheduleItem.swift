//
//  ScheduleItem.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/18/26.
//

import Foundation

struct ScheduleItem: Identifiable {
    
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let title: String
    let detail: String?
    
    func isCurrent(at date: Date = .now) -> Bool {
            date >= startDate && date < endDate
        }

        func hasPassed(at date: Date = .now) -> Bool {
            date >= endDate
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
                startDate: time(hour: 9),
                endDate: time(hour: 9, minute: 30),
                title: "Morning routine",
                detail: nil
            ),
            ScheduleItem(
                startDate: time(hour: 11),
                endDate: time(hour: 12),
                title: "AI class",
                detail: "UNC Charlotte"
            ),
            ScheduleItem(
                startDate: time(hour: 14),
                endDate: time(hour: 15),
                title: "Interview",
                detail: "Horizon Media"
            ),
            ScheduleItem(
                startDate: time(hour: 16),
                endDate: time(hour: 17),
                title: "Portfolio work",
                detail: nil
            ),
            ScheduleItem(
                startDate: time(hour: 18),
                endDate: time(hour: 19),
                title: "Workout",
                detail: nil
            )
        ]
    }()
}
