import Foundation

final class LabelElementModel: RecipeCellElementModel {
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    var type: RecipeCell { return .label }
}
