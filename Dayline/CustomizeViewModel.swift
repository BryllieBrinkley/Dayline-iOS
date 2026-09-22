import Foundation
import Combine

final class CustomizeViewModel: ObservableObject {
    @Published var sections: [DailySection] = DailySection.defaults

}
