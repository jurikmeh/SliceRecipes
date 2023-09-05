import Foundation

protocol RecipeLocalService {
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void)
}
