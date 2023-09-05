import Foundation

public struct ItemList: Codable {
    public let count: Int
    public let results: [Item]
}
