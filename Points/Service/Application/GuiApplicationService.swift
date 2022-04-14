//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import UIKit

final class GuiApplicationService: ApplicationServiceProtocol {
	private var _window: UIWindow?
	var window: UIWindow {
		if let window = _window {
			return window
		} else {
			let window = UIWindow(frame: UIScreen.main.bounds)
			_window = window
			return window
		}
	}

	func onStartApplication(_ application: UIApplication) {
//		startRootScreen()
		startMasterScreen()
	}
}

private extension GuiApplicationService {
	func startRootScreen() {
		let viewController = UIViewController()
		viewController.title = "Points challenge"
		viewController.view = UITableView()
		let navigationController = UINavigationController(
				rootViewController: viewController
		)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}

	func startMasterScreen() {
		let viewController = dependencies.resolve(MasterScreen.self)
		let navigationController = UINavigationController(
				rootViewController: viewController
		)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}
