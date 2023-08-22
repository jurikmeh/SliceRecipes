import Foundation

public struct Item: Codable {
    let name: String?
    let cook_time_minutes: Double?
    let total_time_minutes: Double?
    let canonical_id: String?
    let video_url: String?
    let original_video_url: String?
    let thumbnail_url: String?
    let description: String?
}
