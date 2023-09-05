import UIKit

public final class ButtonCell: UITableViewCell {
    
    private struct Constants {
        static let buttonTextFontSize: CGFloat = 20.0
        static let buttonTopInset: CGFloat = 8.0
        static let buttonLeftInset: CGFloat = 8.0
        static let buttonBottomInset: CGFloat = 8.0
        static let buttonRightInset: CGFloat = 8.0
        static let buttonCornerRadius: CGFloat = 4.0
    }
    
    // MARK: - Properties
    private var buttonCellModel: ButtonElement!
    
    // MARK: - UI
    private lazy var markAsReadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTextFontSize)
        button.contentEdgeInsets = UIEdgeInsets(top: Constants.buttonTopInset, left: Constants.buttonLeftInset, bottom: Constants.buttonBottomInset, right: Constants.buttonRightInset)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        return button
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    @objc func didTap() {
        buttonCellModel.onTap()
    }
    
}

extension ButtonCell: RecipeCell {
    public func configure(withModel model: RecipeCellElement) {
        guard let model = model as? ButtonElement else { return }
        
        self.buttonCellModel = model
        markAsReadButton.setTitle(self.buttonCellModel.title, for: .normal)
    }
}

private extension ButtonCell {
    func setupConstraints() {
        setupMarkAsReadButtonConstraints()
    }
    
    func setupMarkAsReadButtonConstraints() {
        contentView.addSubview(markAsReadButton)
        NSLayoutConstraint.activate([
            markAsReadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            markAsReadButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constants.buttonTopInset),
            markAsReadButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.buttonBottomInset)
        ])
    }
}
