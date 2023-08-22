import Foundation

protocol RecipeDetailViewModelDelegate: AnyObject {
    func didMarkRecipe(_ recipe: Item)
}

final class RecipeDetailViewModelImpl: RecipeDetailViewModel {
    
    // MARK: - Properties
    private let recipe: Item
    private weak var navigator: RecipeListNavigator?
    private weak var delegate: RecipeDetailViewModelDelegate?
    private var cellElementModelArray: [RecipeCellElementModel] = []
    
    var count: Int { recipe.instructions.isEmpty ? 3 : 4 }
    var recipeName: String? { recipe.name }
    
    // MARK: - Init
    init(navigator: RecipeListNavigator, delegate: RecipeDetailViewModelDelegate, recipe: Item) {
        self.navigator = navigator
        self.delegate = delegate
        self.recipe = recipe
        self.cellElementModelArray = [
            ButtonElementModel(title: "Mark as read") { [weak self] in self?.markAsRead(recipe) },
            LabelElementModel(title: "Total time", description: "\(recipe.total_time_minutes ?? 0) mins"),
            LabelElementModel(title: "Cook time", description: "\(recipe.cook_time_minutes ?? 0) mins"),
            InstructionElementModel(instructions: recipe.instructions)
        ]
    }
    
}

extension RecipeDetailViewModelImpl {
    func getCellElementModelArray(at index: Int) -> RecipeCellElementModel { return cellElementModelArray[index] }
}

// MARK: - Extension
extension RecipeDetailViewModelImpl {
    func markAsRead(_ recipe: Item) {
        delegate?.didMarkRecipe(recipe)
        navigator?.navigate(to: .pop)
    }
}
