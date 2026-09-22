import Foundation
import WeatherKit
import CoreLocation
import Observation

@Observable
@MainActor
final class WeatherManager: NSObject,
                            CLLocationManagerDelegate {

    private let weatherService = WeatherService.shared
    private let locationManager = CLLocationManager()

    var currentWeather: CurrentWeather?
    var isLoading = false
    var errorMessage: String?

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy =
            kCLLocationAccuracyKilometer
    }

    func fetchCurrentWeather() {
        errorMessage = nil
        
        switch locationManager.authorizationStatus {

        case .notDetermined:
            isLoading = true
            locationManager.requestWhenInUseAuthorization()

        case .authorizedWhenInUse, .authorizedAlways:
            isLoading = true
            locationManager.requestLocation()

        case .denied, .restricted:
            isLoading = false
            errorMessage =
                "Allow location access in Settings to see local weather."

        @unknown default:
            isLoading = false
            errorMessage = "Unable to access your location."
        }
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus {

        case .authorizedWhenInUse, .authorizedAlways:
            isLoading = true
            manager.requestLocation()

        case .denied, .restricted:
            isLoading = false
            errorMessage =
                "Allow location access in Settings to see local weather."

        default:
            break
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else {
            isLoading = false
            errorMessage = "Your location was unavailable."
            return
        }

        Task {
            await fetchWeather(for: location)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        isLoading = false
        errorMessage =
            "Location failed: \(error.localizedDescription)"
    }

    private func fetchWeather(
        for location: CLLocation
    ) async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            currentWeather =
                try await weatherService.weather(
                    for: location,
                    including: .current
                )
        } catch {
            errorMessage =
                "Weather failed: \(error.localizedDescription)"
        }
    }
}
