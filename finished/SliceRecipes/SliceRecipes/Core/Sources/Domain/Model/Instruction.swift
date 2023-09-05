import Foundation

public struct Instruction: Codable {
    public let display_text: String
    public let start_time: Int
    public let appliance: String?
    public let end_time: Int
    public let temperature: Double?
    public let id: Int
    public let position: Int
}
