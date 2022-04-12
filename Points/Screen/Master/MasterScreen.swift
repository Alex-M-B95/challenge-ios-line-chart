//
//  Created by Alex.M on 12.04.2022
//  

import Foundation
import UIKit

final class MasterScreen: UIViewController {
	// MARK: - Views
	private lazy var rootView = MasterView()

	// MARK: - Object life cycle

	// MARK: - UIViewController life cycle
	override func loadView() {
		rootView.delegate = self
		view = rootView
		setupUI()
	}
}

extension MasterScreen: MasterViewDelegate {
	func didChangeValue(_ value: Int) {
		// TODO: Save value
	}

	func didSubmit() {
		// TODO: Handle saved value
	}
}

private extension MasterScreen {
	func setupUI() {
		title = "Points"
	}
}
