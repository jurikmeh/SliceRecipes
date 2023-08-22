import Foundation

public struct Instruction: Codable {
    let display_text: String
    let start_time: Int
    let appliance: String?
    let end_time: Int
    let temperature: Double?
    let id: Int
    let position: Int
}
