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
                    
                    CurrentWeatherView()
                }
                Spacer()
                ScheduleSectionView()
                Spacer()
                TopThreeSectionView()
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .task {
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
