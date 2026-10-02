import SwiftUI

struct TodaysFocusCard: View {
    
    let title: String
    let message: String
    let systemImage: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.blue.opacity(0.12))

            HStack(spacing: 16) {
                Image(systemName: "calendar")
                    .font(.system(
                        size: 24,
                        weight: .semibold
                    ))
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.blue)
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Today's Focus")
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Text("Interview at 2:00 PM")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontDesign(.serif)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text("Be prepared. You've got this.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(
                        size: 16,
                        weight: .semibold
                    ))
                    .foregroundStyle(.secondary)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
    }
}

#Preview {
    TodaysFocusCard(
        title: "Interview at 2:00 PM",
        message: "Be prepared. You've got this.",
        systemImage: "calendar"
    )
        .padding()
}
