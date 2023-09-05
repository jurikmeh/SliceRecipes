import Foundation

public struct Item: Codable {
    public let name: String?
    public let cook_time_minutes: Double?
    public let total_time_minutes: Double?
    public let canonical_id: String?
    public let video_url: String?
    public let original_video_url: String?
    public let thumbnail_url: String?
    public let description: String?
    public let instructions: [Instruction]
}
