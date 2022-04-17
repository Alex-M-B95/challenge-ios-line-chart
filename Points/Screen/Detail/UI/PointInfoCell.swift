//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit

class PointInfoCell: UITableViewCell {
	// MARK: - Views
	private lazy var abscissaTitleLabel = UILabel()
	private lazy var abscissaLabel = UILabel()
	private lazy var ordinateTitleLabel = UILabel()
	private lazy var ordinateLabel = UILabel()

	// MARK: - Values

	// MARK: - Life cycle
	override init(style: CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	// MARK: - Config
	func config(model: CGPoint) {
		abscissaLabel.text = String(format: "%.2f", model.x)
		ordinateLabel.text = String(format: "%.2f", model.y)
	}
}

// MARK: - Private methods
private extension PointInfoCell {
	func setupUI() {
		contentView.addSubviews(abscissaTitleLabel, abscissaLabel, ordinateTitleLabel, ordinateLabel)

		abscissaTitleLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(10)
			make.leading.equalToSuperview().inset(10)
		}
		abscissaTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		abscissaTitleLabel.font = .preferredFont(forTextStyle: .headline)
		abscissaTitleLabel.text = "X:"

		abscissaLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(10)
			make.leading.equalTo(abscissaTitleLabel.snp.trailing).offset(4)
		}
		abscissaLabel.font = .preferredFont(forTextStyle: .callout)

		ordinateTitleLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(10)
			make.leading.equalTo(contentView.snp.centerX)
			make.trailing.equalTo(abscissaLabel.snp.trailing).offset(30)
		}
		ordinateTitleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		ordinateTitleLabel.font = .preferredFont(forTextStyle: .headline)
		ordinateTitleLabel.text = "Y:"

		ordinateLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(10)
			make.leading.equalTo(ordinateTitleLabel.snp.trailing).offset(4)
			make.trailing.equalToSuperview().inset(10)
		}
		ordinateLabel.font = .preferredFont(forTextStyle: .callout)
	}
}
