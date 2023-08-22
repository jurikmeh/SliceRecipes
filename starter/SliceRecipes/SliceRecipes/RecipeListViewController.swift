import UIKit

class RecipeListViewController: UITableViewController, RecipeDetailViewControllerDelegate {

    let service = NetworkService()
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Slice Recipes"
        service.getRecipes { itemList in
            DispatchQueue.main.async {
                self.items = itemList.results
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let recipeDetailViewController = RecipeDetailViewController(nibName: nil, bundle: nil)
        recipeDetailViewController.recipe = item
        present(recipeDetailViewController, animated: true, completion: nil)
    }

    func didViewRecipe(_ recipe: Item, viewController: RecipeDetailViewController) {}
}
