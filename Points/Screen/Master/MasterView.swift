//
//  Created by Alex.M on 12.04.2022
//  

import Foundation
import UIKit

protocol MasterViewDelegate: AnyObject {
	func didChangeValue(_ value: Int)
	func didSubmit()
}

final class MasterView: UIView {
	// MARK: - Views
	private lazy var titleLabel = UILabel()
	private lazy var textField = UITextField()
	private lazy var submitButton = UIButton()

	// MARK: - Values
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

	// MARK: -
	// MARK: -
}

// MARK: - Private methods
private extension MasterView {
	func setupUI() {
		backgroundColor = .white

		for view in [titleLabel, textField, submitButton] {
			// TODO: Create UIView extension
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
		}

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
			make.leading.trailing.equalToSuperview().inset(20)
		}
		titleLabel.font = .preferredFont(forTextStyle: .title2)
		titleLabel.numberOfLines = 0
		titleLabel.text = "Введите число точек:"

		textField.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.leading.equalToSuperview().inset(20)
			make.trailing.equalToSuperview().inset(20)
		}
		textField.font = .preferredFont(forTextStyle: .headline)
		textField.placeholder = "0"
		textField.addTarget(self, action: #selector(onChangeValue), for: .editingChanged)
		textField.keyboardType = .numberPad

		submitButton.snp.makeConstraints { make in
			make.top.equalTo(textField.snp.bottom).offset(8)
			make.leading.greaterThanOrEqualToSuperview().inset(40)
			make.trailing.lessThanOrEqualToSuperview().inset(40)
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
			  let value = Int(text) else {
			submitButton.isEnabled = false
			return
		}
		submitButton.isEnabled = true
		delegate?.didChangeValue(value)
	}

	@objc
	func onSubmit() {
		delegate?.didSubmit()
	}
}
