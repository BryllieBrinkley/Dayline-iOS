import SwiftUI

struct ConnectionSourceRowView: View {

    let source: OnboardingSourceItem

    private var isConnected: Bool {
        source.isSelected
    }

    private let usesLogo: Set<String> = [
        "Google Calendar",
        "Outlook Calendar",
        "Gmail",
        "Outlook Mail",
        "Slack",
        "Google Drive",
        "Notion",
        "Todoist"
    ]

    var body: some View {
        Button {
            print("Connect or disconnect \(source.isSelected)")
        } label: {
            HStack(spacing: 12) {
                sourceIcon

                Text(source.type.title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)

                Spacer(minLength: 12)

                statusText

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .frame(width: 12)
            }
            .foregroundStyle(.primary)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 56)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    @ViewBuilder
    private var sourceIcon: some View {
        switch source.type.icon {
        case .asset(let imageName):
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .frame(width: 32, height: 32)

        case .system(let symbolName):
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.primary)
                .frame(width: 25, height: 25)
                .frame(width: 32, height: 32)
        }
    }

    private var statusText: some View {
        Text(
            isConnected ? "Connected" : "Not Connected"
        )
        .font(.system(size: 15, weight: .medium))
        .foregroundStyle(
            isConnected ? Color.green : Color.red
        )
        .frame(width: 110, alignment: .trailing)
    }
}

#Preview {
    ConnectionSourceRowView(source: OnboardingSourceItem(type: .notion, isSelected: true))
}
