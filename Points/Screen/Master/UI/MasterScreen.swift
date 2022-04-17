//
//  Created by Alex.M on 12.04.2022
//  

import Foundation
import UIKit

protocol MasterViewInput: AnyObject {
	func navigateToDetail(items: [CGPoint])
	func showError(error: String)
}

final class MasterScreen: UIViewController {
	// MARK: - Views
	private lazy var rootView = MasterView()

	// MARK: - Values
	let presenter: MasterPresenterProtocol

	// MARK: - Object life cycle
	init(presenter: MasterPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		debugPrint(String(describing: type(of: self)), "deinit")
	}

	// MARK: - UIViewController life cycle
	override func loadView() {
		rootView.delegate = self
		view = rootView
		setupUI()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		#if DEBUG
		rootView.config(value: 25)
		#endif
	}
}

extension MasterScreen: MasterViewDelegate {
	func didSubmit() {
		presenter.submit(points: rootView.count)
	}
}

extension MasterScreen: MasterViewInput {
	func navigateToDetail(items: [CGPoint]) {
		let dataSource = DetailDataSource(items: items)
		let screen = DetailScreen(dataSource: dataSource)
		show(screen, sender: self)
	}

	func showError(error: String) {
		showAlert(title: "Error", message: error)
	}
}

private extension MasterScreen {
	func setupUI() {
//		title = "Главный"
	}

	func showAlert(title: String, message: String?) {
		let alert = UIAlertController(
				title: title,
				message: message,
				preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		present(alert, animated: true)
	}
}
