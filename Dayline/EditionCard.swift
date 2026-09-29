import SwiftUI

struct EditionCardView: View {
    
    let edition: Edition
    let onTap: () -> Void

    @State private var isSaved = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink {
                EditionDetailView()
            } label: {
                HStack(alignment: .top, spacing: 14) {
                    Image(edition.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )

                    VStack(alignment: .leading, spacing: 3) {
                        Text(dateTitle)
                            .font(.headline)

                        Text("\(edition.readTime) min read")
                            .font(.subheadline)
                        
                        Text(edition.headline)
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .fixedSize(horizontal: false, vertical: true)                            .layoutPriority(1)
                            .padding(.top, 5)
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
                .foregroundStyle(.primary)
                .padding(14)
                .padding(.trailing, 28)
                .frame(
                    maxWidth: .infinity,
                    minHeight: 140,
                    alignment: .top
                )
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                isSaved.toggle()
            } label: {
                Image(
                    systemName: isSaved
                        ? "bookmark.fill"
                        : "bookmark"
                )
                .font(.system(size: 20))
                .foregroundStyle(
                    isSaved ? .blue : .secondary
                )
            }
            .buttonStyle(.plain)
            .padding(14)
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.secondary, lineWidth: 1)
        }
    }
    
    private var dateTitle: String {
        if Calendar.current.isDateInToday(edition.date) {
            return "Today"
        }

        return edition.date.formatted(
            .dateTime
                .weekday(.wide)
                .month(.abbreviated)
                .day()
        )
    }
}
#Preview {
    EditionCardView(edition: Edition.sampleEditions.first!) {}}

