import UIKit

public final class InstructionCell: UITableViewCell {
    
    private struct Constants {
        static let titleFontSize: CGFloat = 20.0
        static let standardTextFontSize: CGFloat = 17.0
        static let instructionStackViewVerticalSpacing: CGFloat = 4.0
        static let numberOfLinesInLabel: Int = 0
    }
    
    // MARK: - Properties
    private var instructionCellModel: InstructionElement!
    
    // MARK: - UI
    private lazy var preparationLabel: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        $0.textAlignment = .center
        $0.text = "Preparation"
        return $0
    }(UILabel())
    
    private lazy var instructionStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = Constants.instructionStackViewVerticalSpacing
        return $0
    }(UIStackView(arrangedSubviews: [preparationLabel]))
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InstructionCell: RecipeCell {
    public func configure(withModel model: RecipeCellElement) {
        guard let model = model as? InstructionElement else { return }
        self.instructionCellModel = model
        
        let instructions = self.instructionCellModel.instructions.enumerated().map { index, instruction in
            let instructionLabel = UILabel()
            instructionLabel.numberOfLines = Constants.numberOfLinesInLabel
            instructionLabel.textAlignment = .justified
            instructionLabel.font = UIFont.systemFont(ofSize: Constants.standardTextFontSize)
            
            let instructionText = "Step \(index + 1): \(instruction.display_text)"
            let attributedString = NSMutableAttributedString(string: instructionText)
            let range = (instructionText as NSString).range(of: "Step \(index + 1):")
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: Constants.standardTextFontSize), range: range)
            
            instructionLabel.attributedText = attributedString
            return instructionLabel
        }
        
        instructions.forEach { instructionStackView.addArrangedSubview($0) }
    }
}

private extension InstructionCell {
    func setupConstraints() {
        setupStackViewConstraints()
    }
    
    func setupStackViewConstraints() {
        contentView.addSubview(instructionStackView)
        NSLayoutConstraint.activate([
            instructionStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            instructionStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            instructionStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            instructionStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
