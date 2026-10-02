import Foundation
import Observation

@MainActor
@Observable
final class SourcesViewModel {

    var sources: [OnboardingSourceItem] = OnboardingSourceItem.defaults

    var editionTime = "7:00 AM"
}

