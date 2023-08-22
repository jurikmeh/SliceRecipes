import Foundation

enum RecipeCell {
    case markAsRead
    case label
    case instruction
    
    var cellIdentifier: String {
        switch self {
        case .markAsRead:
            return "buttonCell"
        case .label:
            return "labelCell"
        case .instruction:
            return "instructionCell"
        }
    }
}
