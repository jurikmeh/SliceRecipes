import Foundation
import Domain
import Error
import Network

public final class RecipeServiceImpl: RecipeService {
    
    private let networkService: NetworkService
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    public func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void) {
        let endpoint = GetRecipesEndpoint()
        networkService.executeRequest(endpoint: endpoint) { result in
            completion(result)
        }
    }
    
}
