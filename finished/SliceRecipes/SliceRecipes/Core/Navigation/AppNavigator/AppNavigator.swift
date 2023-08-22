import UIKit

final class AppNavigator {
    let window: UIWindow
    private let diContainer: DIContainer
    private var childNavigators: [ChildNavigator]
    
    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
        self.childNavigators = [
            RecipeListNavigator(diContainer: diContainer)
        ]
        
        self.window.rootViewController = self.childNavigators[0].start()
        self.window.makeKeyAndVisible()
    }
}
