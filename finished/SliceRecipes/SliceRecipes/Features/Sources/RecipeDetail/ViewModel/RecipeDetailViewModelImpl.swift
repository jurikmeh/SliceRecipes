import Foundation
import Domain
import Navigation

public protocol RecipeDetailViewModelDelegate: AnyObject {
    func didMarkRecipe(_ recipe: Item)
}

public final class RecipeDetailViewModelImpl: RecipeDetailViewModel {
    
    // MARK: - Properties
    private let recipe: Item
    private weak var delegate: RecipeDetailViewModelDelegate?
    private var cellElementModelArray: [RecipeCellElement] = []
    
    public var count: Int { recipe.instructions.isEmpty ? 3 : 4 }
    public var recipeName: String? { recipe.name }
    
    // MARK: - Init
    public init(delegate: RecipeDetailViewModelDelegate, recipe: Item) {
        self.delegate = delegate
        self.recipe = recipe
        self.cellElementModelArray = [
            ButtonElement(title: "Mark as read") { [weak self] in self?.markAsRead(recipe) },
            LabelElement(title: "Total time", description: "\(recipe.total_time_minutes ?? 0) mins"),
            LabelElement(title: "Cook time", description: "\(recipe.cook_time_minutes ?? 0) mins"),
            InstructionElement(instructions: recipe.instructions)
        ]
    }
    
}

extension RecipeDetailViewModelImpl {
    public func getCellElementModelArray(at index: Int) -> RecipeCellElement { cellElementModelArray[index] }
}

// MARK: - Extension
extension RecipeDetailViewModelImpl {
    public func markAsRead(_ recipe: Item) {
        delegate?.didMarkRecipe(recipe)
    }
}
