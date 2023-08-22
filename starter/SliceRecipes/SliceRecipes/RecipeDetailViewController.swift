import UIKit

protocol RecipeDetailViewControllerDelegate {
    func didViewRecipe(_ recipe: Item, viewController: RecipeDetailViewController)
}

class RecipeDetailViewController: UIViewController {

    var delegate: RecipeDetailViewControllerDelegate?
    var recipe: Item?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .lightGray
        button.setTitle("Mark as Read", for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        let constraints = [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc func didTap() {
        self.delegate?.didViewRecipe(recipe!, viewController: self)
    }
}
