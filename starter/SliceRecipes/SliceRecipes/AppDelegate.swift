import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: RecipeListViewController(nibName: nil, bundle: nil))
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

