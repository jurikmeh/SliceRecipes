import Foundation

final class RecipeServiceImpl: RecipeService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void) {
        let endpoint = GetRecipesEndpoint()
        networkService.executeRequest(endpoint: endpoint) { result in
            completion(result)
        }
    }
    
}
