import Foundation

final class RecipeFacadeImpl: RecipeFacade {
    
    // MARK: - Properties
    private let recipeService: RecipeService
    private let recipeLocalService: RecipeLocalService
    
    // MARK: - Init
    init(recipeService: RecipeService, recipeLocalService: RecipeLocalService) {
        self.recipeService = recipeService
        self.recipeLocalService = recipeLocalService
    }
    
    // MARK: - RecipeFacade
    func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void) {
        recipeService.fetchRecipes { [weak self] result in
            switch result {
            case .success(let itemListFromNetwork):
                completion(.success(itemListFromNetwork))
            case .failure(_):
                self?.recipeLocalService.fetchRecipes { result in
                    if case .success(let itemListFromJson) = result {
                        completion(.success(itemListFromJson))
                    } else {
                        completion(.failure(SliceError(message: "Couldn't get recipes from local file")))
                    }
                }
            }
        }
    }
    
}
