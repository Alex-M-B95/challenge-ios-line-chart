//
//  Created by Alex.M on 12.04.2022
//  

import Foundation
import UIKit

final class MasterScreen: UIViewController {
	// MARK: - Views
	private lazy var rootView = MasterView()

	// MARK: - Values
	let presenter: MasterPresenterProtocol

	init(presenter: MasterPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Object life cycle

	// MARK: - UIViewController life cycle
	override func loadView() {
		rootView.delegate = self
		view = rootView
		setupUI()
	}
}

extension MasterScreen: MasterViewDelegate {
	func didSubmit() {
		presenter.submit(points: rootView.count)
	}
}

private extension MasterScreen {
	func setupUI() {
		title = "Points"
	}
}
