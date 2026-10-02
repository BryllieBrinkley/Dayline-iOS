import Foundation
import Combine

final class SelectConnectionsViewModel: ObservableObject {
    @Published var isEmailSelected: Bool = false
    @Published var isCalendarSelected: Bool = false
    @Published var isRemindersSelected: Bool = false
    @Published var isInterestsSelected: Bool = false
}
