import UIKit

final class LabelCell: UITableViewCell {
    
    private struct Constants {
        static let titleFontSize: CGFloat = 20.0
        static let descriptionFontSize: CGFloat = 17.0
        
        static let labelTopPadding: CGFloat = 4.0
        static let labelBetweenPadding: CGFloat = 4.0
        static let labelBottomPadding: CGFloat = 4.0
    }
    
    // MARK: - Properties
    private var labelCellModel: LabelElementModel!
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var descriptionLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LabelCell: RecipeCellElement {
    func configure(withModel model: RecipeCellElementModel) {
        guard let model = model as? LabelElementModel else { return }
        
        self.labelCellModel = model
        configureViews(title: self.labelCellModel.title, description: self.labelCellModel.description)
    }
}

private extension LabelCell {
    func configureViews(title: String, description: String) {
        configureTitleLabel(title: title)
        configureDescriptionLabel(description: description)
    }
    
    func configureTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func configureDescriptionLabel(description: String) {
        descriptionLabel.text = description
    }
}

private extension LabelCell {
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
    }
    
    func setupTitleLabelConstraints() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.labelTopPadding)
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.labelBetweenPadding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.labelBottomPadding)
        ])
    }
}
