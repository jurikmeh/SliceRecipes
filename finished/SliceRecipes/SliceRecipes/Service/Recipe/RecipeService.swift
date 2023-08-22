import Foundation

protocol RecipeService {
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void)
}
