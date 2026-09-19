import SwiftUI

struct ScheduleRowView: View {

    let item: ScheduleItem

    var isFirst = false
    var isLast = false

    private var isCurrent: Bool {
        item.isCurrent()
    }

    private var hasPassed: Bool {
        item.hasPassed()
    }

    private var markerColor: Color {
        if isCurrent || hasPassed {
            return .blue
        } else {
            return .gray
        }
    }

    var body: some View {
        HStack(spacing: 12) {

            Text(
                item.startDate.formatted(
                    date: .omitted,
                    time: .shortened
                )
            )
            .font(.subheadline)
            .foregroundStyle(
                isCurrent ? .blue : .secondary
            )
            .frame(
                width: 75,
                alignment: .trailing
            )

            timelineMarker

            HStack(spacing: 8) {
                Text(item.title)
                    .font(.body)
                    .fontWeight(
                        isCurrent ? .semibold : .regular
                    )
                    .lineLimit(1)

                if let detail = item.detail {
                    Text(detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
        .padding(.horizontal, 8)
        .frame(height: 48)
        .background {
            if isCurrent {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue.opacity(0.10))
            }
        }
    }

    private var timelineMarker: some View {
        VStack(spacing: 0) {

            Rectangle()
                .fill(.gray.opacity(0.30))
                .frame(width: 2)
                .opacity(isFirst ? 0 : 1)

            Circle()
                .fill(markerColor)
                .frame(width: 10, height: 10)

            Rectangle()
                .fill(.gray.opacity(0.30))
                .frame(width: 2)
                .opacity(isLast ? 0 : 1)
        }
        .frame(width: 16, height: 48)
    }
}

#Preview {
    ScheduleRowView(
        item: ScheduleItem(
            startDate: .now.addingTimeInterval(-1_800),
            endDate: .now.addingTimeInterval(1_800),
            title: "Interview",
            detail: "Horizon Media"
        ),
        isFirst: true,
        isLast: true
    )
    .padding()
}
