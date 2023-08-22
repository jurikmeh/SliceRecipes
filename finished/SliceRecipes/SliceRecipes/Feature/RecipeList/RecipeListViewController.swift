import UIKit

final class RecipeListViewController: UIViewController {
    
    // MARK: - Constants
    private struct Constants {
        static let cellIdentifier = "recipeCell"
    }
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        $0.startAnimating()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIActivityIndicatorView(style: .large))
    
    // MARK: - Stored Properties
    var viewModel: RecipeListViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupConstraints()
        
        viewModel?.fetchRecipes()
        
        viewModel?.onReload = { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicatorView.stopAnimating()
        }
        
        viewModel?.onMarkAsRead = { [weak self] index in
            self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
    
}

// MARK: - UITableViewDataSource
extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        guard let recipe = viewModel?.getRecipe(atIndex: indexPath.row) else { return UITableViewCell() }
        cell.textLabel?.text = recipe.name
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = viewModel?.getRecipe(atIndex: indexPath.row) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didTapOnRecipe(recipe)
    }
}

// MARK: - Extension for configuring views and its constraints
private extension RecipeListViewController {
    func configureViews() {
        // methods for every view go here, but I just setup the `title` and `backgroundColor` for the sake of simplicity
        title = "Slice Recipes"
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
