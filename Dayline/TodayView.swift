import SwiftUI
import WeatherKit
import CoreLocation
import os

struct TodayView: View {

    let currentDate = Date()

    @State private var weatherManager = WeatherManager()

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 12
            ) {
                headerWithProfilePicView
                
                Text("Good morning, User")
                    .font(.system(
                        .largeTitle,
                        design: .serif,
                        weight: .semibold
                    ))

                HStack {
                    Text(
                        currentDate.formatted(
                            date: .complete,
                            time: .omitted
                        )
                    )
                    .font(.headline)
                    .lineLimit(1)

                    Spacer()
                    currentWeatherView
                }
                TodaysFocusCard(
                    title: "Interview at 2:00 PM",
                    message: "Be prepared. You've got this.",
                    systemImage: "calendar"
                )
                TopThreeSectionView()
                Spacer()
                ScheduleSectionView()
                
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .task {
            // Defer a touch to let first frame render
            try? await Task.sleep(nanoseconds: 150_000_000)
            await MainActor.run {
                weatherManager.fetchCurrentWeather()
            }
        }
        .onAppear {
            os_log("TodayView appeared at %{public}@", String(describing: Date()))
        }
    }

    @ViewBuilder
    private var currentWeatherView: some View {
        if let currentWeather =
            weatherManager.currentWeather {

            HStack(spacing: 6) {
                Image(systemName: currentWeather.symbolName)
                    .font(.system(size: 26))
                    .symbolRenderingMode(.multicolor)

                Text(
                    currentWeather.temperature.formatted(
                        .measurement(
                            width: .abbreviated,
                            usage: .weather,
                            numberFormatStyle: .number
                                .precision(.fractionLength(0))
                        )
                    )
                )
                .font(.title2)
                .fontWeight(.semibold)
            }

        } else if weatherManager.isLoading {

            ProgressView()

        } else if let errorMessage =
                    weatherManager.errorMessage {

            Text(errorMessage)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var headerWithProfilePicView: some View {
        HStack {
            Text("Dayline")
                .font(.system(size: 48,
                              weight: .bold,
                              design: .serif))
                .padding(.leading)
            
            Spacer()
            
            Image("mock-profile-pic")
                .resizable()
                .frame(
                    width: 75,
                    height: 75
                )
                .scaledToFit()
                .clipShape(.circle)
                .padding()
        }
    }
}


#Preview {
    TodayView()
}
