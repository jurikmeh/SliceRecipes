import Foundation

protocol RecipeDetailViewModel {
    var recipeName: String? { get }
    var count: Int { get }
    
    func markAsRead(_ recipe: Item)
    func getCellElementModelArray(at index: Int) -> RecipeCellElementModel
}
