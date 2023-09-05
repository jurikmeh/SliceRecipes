import UIKit
import Domain
import DiLib
import Navigation
import Error
import RecipeDetail

public final class RecipeListNavigator {
    
    public enum Destination {
        case pop
        case recipeDetails(recipe: Item)
    }
    
    private let navigationController: UINavigationController
    private let diContainer: DIContainer
    
    public init(
        diContainer: DIContainer,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.diContainer = diContainer
        
        let recipeListViewController = RecipeListViewController()
        self.navigationController = UINavigationController(rootViewController: recipeListViewController)
        let recipeListViewModel = RecipeListViewModelImpl(navigator: self, recipeFacade: diContainer.resolve())
        recipeListViewController.viewModel = recipeListViewModel
    }
    
    func presentError(error: SliceError) {
        let alert = configureErrorAlert(error: error)
        navigationController.present(alert, animated: true)
    }
    
}

extension RecipeListNavigator: ChildNavigator {
    public func start() -> UIViewController {
        return navigationController
    }
}

extension RecipeListNavigator: Navigator {
    public func navigate(to destination: RecipeListNavigator.Destination) {
        switch destination {
        case .pop:
            navigationController.popViewController(animated: true)
            
        case .recipeDetails(let recipe):
            let recipeDetailViewController = RecipeDetailViewController()
            guard let recipeListViewController = navigationController.viewControllers.first(where: { $0 is RecipeListViewController }) as? RecipeListViewController else { return }
            guard recipeListViewController.viewModel != nil else { return }
            let recipeDetailViewModel = RecipeDetailViewModelImpl(delegate: recipeListViewController.viewModel!, recipe: recipe)
            recipeDetailViewController.viewModel = recipeDetailViewModel
            navigationController.pushViewController(recipeDetailViewController, animated: true)
        }
    }
}
