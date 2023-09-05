import Foundation
import Domain
import Error

public protocol RecipeFacade {
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void)
}
