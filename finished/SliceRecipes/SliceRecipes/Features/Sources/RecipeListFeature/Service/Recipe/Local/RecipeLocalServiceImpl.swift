import Foundation
import Domain
import Error

public final class RecipeLocalServiceImpl: RecipeLocalService {
    
    // MARK: - Constants
    private struct Constants {
        static let jsonFormat: String = "json"
        static let jsonFileName: String = "recipes"
    }
    
    // MARK: - Init
    public init() {}
    
    // MARK: - RecipeService
    public func fetchRecipes(_ completion: @escaping (Result<ItemList, SliceError>) -> Void) {
        guard let recipesData = getDataFromJsonFile(named: Constants.jsonFileName) else {
            completion(.failure(SliceError(message: "Couldn't get data from json file")))
            return
        }
        
        do {
            let itemList = try JSONDecoder().decode(ItemList.self, from: recipesData)
            completion(.success(itemList))
        } catch {
            completion(.failure(SliceError(message: "Couldn't get data from \(Constants.jsonFileName).\(Constants.jsonFormat)")))
        }
    }
    
}

// MARK: - Extensions
private extension RecipeLocalServiceImpl {
    func getDataFromJsonFile(named fileName: String) -> Data? {
        if let path = Bundle.module.url(forResource: fileName, withExtension: Constants.jsonFormat) {
            do {
                let data = try Data(contentsOf: path)
                return data
            } catch {
                print("Error reading JSON file: \(error)")
                return nil
            }
        }
        return nil
    }
}
