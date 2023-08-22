import Foundation

final class ButtonElementModel: RecipeCellElementModel {
    let title: String
    let onTap: () -> Void
    
    init(title: String, onTap: @escaping () -> Void) {
        self.title = title
        self.onTap = onTap
    }
    
    var type: RecipeCell { return .markAsRead }
}
