import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appNavigator: AppNavigator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let diContainer: DIContainer = DIContainerImpl()
        diContainer.register(GetApiHostUseCase.self) { _ in GetApiHostUseCaseImpl() }
        diContainer.register(NetworkService.self) { resolver in
            guard let getApiHostUseCase = resolver.resolve(GetApiHostUseCase.self) else {
                fatalError("GetApiHostUseCase has not been registered")
            }
            return NetworkServiceImpl(getApiHostUseCase: getApiHostUseCase)
        }
        diContainer.register(RecipeService.self) { resolver in
            guard let networkService = resolver.resolve(NetworkService.self) else {
                fatalError("NetworkService has not been registered")
            }
            
            return RecipeServiceImpl(networkService: networkService)
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        appNavigator = AppNavigator(window: window, diContainer: diContainer)
        self.window = appNavigator?.window
        
        return true
    }
}
