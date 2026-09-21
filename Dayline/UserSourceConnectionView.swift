import SwiftUI

struct UserSourceConnectionView: View {

    @State private var viewModel = SourcesViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            headerView
            sourceList
        }
        .padding(.top, 12)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Sources")
                .font(
                    .system(
                        size: 34,
                        weight: .bold,
                        design: .serif
                    )
                )

            Text("Connect the tools you use. Dayline only uses the apps that you allow it to access.")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 20)
    }

    private var sourceList: some View {
        List {
            ForEach(viewModel.sources) { source in
                ConnectionSourceRowView(source: source)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 4,
                            bottom: 0,
                            trailing: 4
                        )
                    )
                    .listRowSeparatorTint(.secondary.opacity(0.2))
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    UserSourceConnectionView()
}
