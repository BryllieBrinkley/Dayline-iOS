import Foundation
import Combine

final class WelcomeViewModel: ObservableObject {
    @Published var isReadyToFinishOnboarding: Bool = false

    let connectionsViewModel = SelectConnectionsViewModel()

    init() {}
    func completeOnboarding() {
        isReadyToFinishOnboarding = true
    }
}
