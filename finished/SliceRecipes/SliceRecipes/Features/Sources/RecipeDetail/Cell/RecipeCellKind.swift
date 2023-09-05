import Foundation

public enum RecipeCellKind {
    case markAsRead
    case label
    case instruction
    
    public var cellIdentifier: String {
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
