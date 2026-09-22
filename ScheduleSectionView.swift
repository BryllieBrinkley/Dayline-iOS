//
//  ScheduleSectionView.swift
//  Dayline
//
//  Created by Jibryll Brinkley on 9/18/26.
//

import SwiftUI

import SwiftUI

struct ScheduleSectionView: View {

    let scheduleItems = ScheduleItem.sampleItems

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Text("Your Schedule")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Button("See all") {
                    print("Open full schedule")
                }
                .font(.subheadline)
            }
            .padding(.bottom, 6)

            Divider()

            ForEach(
                Array(scheduleItems.enumerated()),
                id: \.element.id
            ) { entry in

                let index = entry.offset
                let item = entry.element

                ScheduleRowView(
                    item: item,
                    isFirst: index == 0,
                    isLast: index == scheduleItems.count - 1
                )
            }
        }
    }
}

#Preview {
    ScheduleSectionView()
}
