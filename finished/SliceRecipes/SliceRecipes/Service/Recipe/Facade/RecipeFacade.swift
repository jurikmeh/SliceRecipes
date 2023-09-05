import Foundation

protocol RecipeFacade {
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void)
}
