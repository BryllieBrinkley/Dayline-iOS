import SwiftUI

struct ConnectionSourceRowView: View {

    let source: SourceItem

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
            print("Connect or disconnect \(source.name)")
        } label: {
            HStack(spacing: 12) {
                sourceIcon

                Text(source.name)
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
        if usesLogo.contains(source.name) {
            Image(source.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .frame(width: 32, height: 32)
        } else {
            Image(systemName: source.icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.primary)
                .frame(width: 25, height: 25)
                .frame(width: 32, height: 32)
        }
    }

    private var statusText: some View {
        Text(
            source.connectionStatus == .connected
                ? "Connected"
                : "Not Connected"
        )
        .font(.system(size: 15, weight: .medium))
        .foregroundStyle(
            source.connectionStatus == .connected
                ? Color.green
                : Color.red
        )
        .frame(width: 110, alignment: .trailing)
    }
}

#Preview {
    ConnectionSourceRowView(
        source: SourceItem(
            name: "Outlook Mail",
            icon: "outlook-mail-logo",
            connectionStatus: .connected
        )
    )
}
