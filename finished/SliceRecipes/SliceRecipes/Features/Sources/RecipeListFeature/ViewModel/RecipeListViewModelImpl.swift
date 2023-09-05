import Foundation
import Domain

final class RecipeListViewModelImpl: RecipeListViewModel {
    
    // MARK: - Properties
    private let recipeFacade: RecipeFacade
    private weak var navigator: RecipeListNavigator?
    private(set) var items: [Item]
    
    var count: Int { items.count }
    
    // MARK: - Callbacks
    var onReload: (() -> Void)?
    var onMarkAsRead: ((Int) -> Void)?
    
    // MARK: - Init
    init(navigator: RecipeListNavigator, recipeFacade: RecipeFacade, items: [Item] = []) {
        self.navigator = navigator
        self.recipeFacade = recipeFacade
        self.items = items
    }
    
    // MARK: - RecipeListViewModel
    func getRecipe(atIndex index: Int) -> Item { items[index] }
    
    func fetchRecipes() {
        recipeFacade.fetchRecipes() { [weak self] completion in
            DispatchQueue.main.async {
                switch completion {
                case .success(let itemList):
                    self?.items = itemList.results
                    self?.onReload?()
                case .failure(let error):
                    self?.navigator?.presentError(error: error)
                    self?.onReload?()
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
        
        DispatchQueue.main.async { [weak self] in
            self?.onMarkAsRead?(recipeIndex)
            self?.navigator?.navigate(to: .pop)
        }
    }
    
}
