import UIKit

public final class RecipeDetailViewController: UIViewController {
    
    // MARK: - Constants
    private struct Constants {
        static let buttonCell = "buttonCell"
        static let labelCell  = "labelCell"
        static let instructionCell = "instructionCell"
    }
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        $0.register(ButtonCell.self, forCellReuseIdentifier: Constants.buttonCell)
        $0.register(LabelCell.self, forCellReuseIdentifier: Constants.labelCell)
        $0.register(InstructionCell.self, forCellReuseIdentifier: Constants.instructionCell)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UITableView())

    // MARK: - Properties
    public var viewModel: RecipeDetailViewModel?
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupConstraints()
    }
    
}

// MARK: - UITableViewDataSource
extension RecipeDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellElementModel = viewModel?.getCellElementModelArray(at: indexPath.row) else { return UITableViewCell() }
        let cellElementModelIdentifier = cellElementModel.kind.cellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellElementModelIdentifier, for: indexPath) as? RecipeCell else { return UITableViewCell() }
        cell.configure(withModel: cellElementModel)
        
        return cell as! UITableViewCell
    }
}

// MARK: - UITableViewDelegate
extension RecipeDetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extensions
private extension RecipeDetailViewController {
    func configureViews() {
        self.view.backgroundColor = .white
        title = viewModel?.recipeName
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
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
