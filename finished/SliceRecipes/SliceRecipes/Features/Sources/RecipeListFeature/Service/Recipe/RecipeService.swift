import Foundation
import Domain
import Error

public protocol RecipeService {
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void)
}
