import Foundation

struct ButtonElement: RecipeCellElement {
    let title: String
    let onTap: () -> Void
    
    var kind: RecipeCellKind { .markAsRead }
}
