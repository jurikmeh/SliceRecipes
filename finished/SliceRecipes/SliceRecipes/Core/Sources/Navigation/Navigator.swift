import UIKit
import Error

public protocol Navigator: AnyObject {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}

public extension Navigator {
    func configureErrorAlert(error: SliceError) -> UIAlertController {
        let alert = UIAlertController(title: "An error occurred", message: error.message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(cancelAction)
        return alert
    }
}
