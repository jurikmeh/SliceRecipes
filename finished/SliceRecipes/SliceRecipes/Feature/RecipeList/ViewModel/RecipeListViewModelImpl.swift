import Foundation

final class RecipeListViewModelImpl: RecipeListViewModel {
    
    // MARK: - Properties
    private let recipeService: RecipeService
    private weak var navigator: RecipeListNavigator?
    private(set) var items: [Item]
    
    var count: Int { items.count }
    
    // MARK: - Callbacks
    var onReload: (() -> Void)?
    var onMarkAsRead: ((Int) -> Void)?
    
    // MARK: - Init
    init(navigator: RecipeListNavigator, recipeService: RecipeService, items: [Item] = []) {
        self.navigator = navigator
        self.recipeService = recipeService
        self.items = items
    }
    
    // MARK: - RecipeListViewModel
    func getRecipe(atIndex index: Int) -> Item { items[index] }
    
    func fetchRecipes() {
        recipeService.fetchRecipes() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let itemList):
                    self?.items = itemList.results
                    self?.onReload?()
                case .failure(let error):
                    self?.navigator?.presentError(error: error)
                }
            }
        }
    }
    
    func didTapOnRecipe(_ recipe: Item) {
        navigator?.navigate(to: .recipeDetails(recipe: recipe))
    }
    
    func didMarkRecipe(_ recipe: Item) {
        guard let recipeIndex = items.firstIndex(where: { $0.canonical_id == recipe.canonical_id }) else { return }
        items.remove(at: recipeIndex)
        onMarkAsRead?(recipeIndex)
    }
    
}
