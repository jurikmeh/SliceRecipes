import Foundation

protocol RecipeListViewModel: RecipeDetailViewModelDelegate {
    var count: Int { get }
    func getRecipe(atIndex index: Int) -> Item
    func fetchRecipes()
    var onReload: (() -> Void)? { get set }
    var onMarkAsRead: ((Int) -> Void)? { get set }
    func didTapOnRecipe(_ recipe: Item)
}

