//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit

class DetailSortSwitchView: UIView {
	// MARK: - Views
	private lazy var titleLabel = UILabel()
	private lazy var switchView = UISwitch()

	// MARK: - Values
	var isOn: Bool {
		get { switchView.isOn }
		set { switchView.isOn = newValue }
	}

	// MARK: - Life cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	// MARK: - Config
	func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event = .valueChanged) {
		switchView.addTarget(target, action: action, for: .valueChanged)
	}
}

// MARK: - Private methods
private extension DetailSortSwitchView {
	func setupUI() {
		addSubviews(titleLabel, switchView)
		titleLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalToSuperview()
		}
		titleLabel.font = .preferredFont(forTextStyle: .caption1)
		titleLabel.text = "Сортировка"

		switchView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.equalTo(titleLabel.snp.trailing).offset(8)
			make.trailing.equalToSuperview()
		}
		switchView.isOn = false
	}
}
