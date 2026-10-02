import SwiftUI

enum AppTab {
    case today
    case editions
    case customize
    case you
}

struct RootTabView: View {

    @State private var selectedTab: AppTab = .today

    var body: some View {
        TabView(selection: $selectedTab) {

            Tab(
                "Today",
                systemImage: selectedTab == .today
                    ? "house.fill"
                    : "house",
                value: .today
            ) {
                NavigationStack {
                    TodayView()
                }
            }

            Tab(
                "Editions",
                systemImage: selectedTab == .editions
                    ? "newspaper.fill"
                    : "newspaper",
                value: .editions
            ) {
                NavigationStack {
                    PastEditionsView()
                }
            }

            Tab(
                "Customize",
                systemImage: "slider.horizontal.3",
                value: .customize
            ) {
                NavigationStack {
                    CustomizeView()
                }
            }

            Tab(
                "You",
                systemImage: selectedTab == .you
                    ? "person.fill"
                    : "person",
                value: .you
            ) {
                NavigationStack {
                    SourcesView()
                }
            }
        }
        .tint(.blue)
        .toolbarBackground(
            Color(.systemBackground),
            for: .tabBar
        )
        .toolbarBackground(
            .visible,
            for: .tabBar
        )
    }
}

#Preview {
    RootTabView()
}
