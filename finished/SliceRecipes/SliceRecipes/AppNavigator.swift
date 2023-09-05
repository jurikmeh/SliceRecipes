import UIKit
import Navigation
import DiLib
import RecipeListFeature

public final class AppNavigator {
    public let window: UIWindow
    private let diContainer: DIContainer
    private var childNavigators: [ChildNavigator]
    
    public init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
        self.childNavigators = [
            RecipeListNavigator(diContainer: diContainer)
        ]
        
        self.window.rootViewController = self.childNavigators[0].start()
        self.window.makeKeyAndVisible()
    }
}
