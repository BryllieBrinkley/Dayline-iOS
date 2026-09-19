import SwiftUI

struct EditionCardView: View {
    
    var edition: Edition
    @State private var isSaved: Bool = false

    var body: some View {
        Button {
            print("Open \(edition.headline)")
        } label: {
            HStack(alignment: .top, spacing: 14) {
                Image(edition.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 112, height: 112)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )

                VStack(alignment: .leading, spacing: 3) {
                    Text(dateTitle)
                        .font(.headline)

                    Text("\(edition.readTime) min read")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(edition.headline)
                        .font(
                            .system(
                                size: 20,
                                weight: .semibold,
                                design: .serif
                            )
                        )
                        .lineLimit(3)
                        .lineSpacing(-1)
                        .padding(.top, 5)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                
                Button {
                    isSaved.toggle()
                } label: {
                    Image(
                        systemName: isSaved
                        ? "bookmark.fill" : "bookmark"
                    )
                    .font(.system(size: 24))
                    .foregroundStyle(
                        isSaved ? .blue : .secondary
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .contentShape(Rectangle())
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        Color.black.opacity(0.2),
                        lineWidth: 1
                    )
                    
            }
        }
        .buttonStyle(.plain)
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
    EditionCardView(edition: Edition.sampleEditions.first!)
}

