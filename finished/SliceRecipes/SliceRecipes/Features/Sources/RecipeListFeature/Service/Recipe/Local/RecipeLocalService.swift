import Foundation
import Domain
import Error

public protocol RecipeLocalService {
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void)
}
