import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    
    let weatherManager = WeatherManager()
    
    var body: some View {
            if let currentWeather =
                weatherManager.currentWeather {

                HStack(spacing: 6) {
                    Image(systemName: currentWeather.symbolName)
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
//                    .font(.title2)
//                    .fontWeight(.semibold)
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
}

#Preview {
    CurrentWeatherView()
}
