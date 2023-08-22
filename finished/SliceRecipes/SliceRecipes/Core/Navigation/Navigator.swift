import UIKit

protocol Navigator: AnyObject {
    associatedtype Destination
    
    func navigate(to destination: Destination)
}

extension Navigator {
    func configureErrorAlert(error: SliceError) -> UIAlertController {
        let alert = UIAlertController(title: "An error occurred", message: error.message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(cancelAction)
        return alert
    }
}
