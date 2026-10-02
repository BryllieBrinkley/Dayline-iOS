import SwiftUI
import EventKit

struct ScheduleSectionView: View {
    @StateObject private var viewModel = ScheduleSectionViewModel()
    
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

            ForEach(Array(viewModel.scheduleItems.enumerated()), id: \.element.id) { entry in
                let index = entry.offset
                let item = entry.element

                ScheduleRowView(
                    item: item,
                    isFirst: index == 0,
                    isLast: index == viewModel.scheduleItems.count - 1
                )
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

