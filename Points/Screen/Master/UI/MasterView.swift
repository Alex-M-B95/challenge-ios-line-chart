//
//  Created by Alex.M on 12.04.2022
//  

import Foundation
import UIKit

protocol MasterViewDelegate: AnyObject {
	func didSubmit()
}

final class MasterView: UIView {
	// MARK: - Views
	private lazy var titleLabel = UILabel()
	private lazy var textField = UITextField()
	private lazy var submitButton = UIButton()

	// MARK: - Values
	private(set) var count: Int = 0
	weak var delegate: MasterViewDelegate?

	// MARK: - Object life cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	// MARK: - Config
	func config(value: Int) {
		textField.text = "\(value)"
		onChangeValue()
	}
}

// MARK: - Private methods
private extension MasterView {
	func setupUI() {
		backgroundColor = .white
		addSubviews(titleLabel, textField, submitButton)

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(20)
		}
		titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		titleLabel.font = .preferredFont(forTextStyle: .title2)
		titleLabel.numberOfLines = 0
		titleLabel.text = "Введите число точек:"

		textField.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
			make.leading.equalTo(titleLabel.snp.trailing).offset(4)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(20)
			make.height.equalTo(titleLabel.snp.height)
		}
		textField.font = .preferredFont(forTextStyle: .headline)
		textField.placeholder = "0"
		textField.textAlignment = .right
		textField.addTarget(self, action: #selector(onChangeValue), for: .editingChanged)
		textField.keyboardType = .numberPad

		submitButton.snp.makeConstraints { make in
			make.top.equalTo(textField.snp.bottom).offset(20)
			make.leading.greaterThanOrEqualTo(safeAreaLayoutGuide.snp.leading).inset(20)
			make.trailing.lessThanOrEqualTo(safeAreaLayoutGuide.snp.trailing).inset(40)
			make.centerX.equalToSuperview()
		}
		submitButton.setTitle("Загрузить", for: [])
		submitButton.setTitleColor(.black, for: [])
		submitButton.setTitleColor(.black.withAlphaComponent(0.7), for: .highlighted)
		submitButton.setTitleColor(.black.withAlphaComponent(0.54), for: .disabled)
		submitButton.isEnabled = false
		submitButton.titleLabel?.font = .preferredFont(forTextStyle: .title3)
		submitButton.addTarget(self, action: #selector(onSubmit), for: .touchUpInside)
	}

	@objc
	func onChangeValue() {
		guard let text = textField.text,
			  !text.isEmpty,
			  let value = Int(text),
			  value > 0 else {
			submitButton.isEnabled = false
			return
		}
		submitButton.isEnabled = true
		count = value
	}

	@objc
	func onSubmit() {
		delegate?.didSubmit()
	}
}
