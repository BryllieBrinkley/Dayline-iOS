import Foundation

enum ConnectionStatus: String, Codable, Hashable {
    case connected
    case disconnected
    case connecting
    case denied
}
