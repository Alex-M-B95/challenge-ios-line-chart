//
//  Created by Alex.M on 11.04.2022.
//

import UIKit

@main
class ApplicationDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
//		startRootScreen()
		startMasterScreen()
		return true
	}
}

private extension ApplicationDelegate {
	var rootWindow: UIWindow {
		if let window = window {
			return window
		} else {
			let window = UIWindow(frame: UIScreen.main.bounds)
			self.window = window
			return window
		}
	}

	func startRootScreen() {
		let viewController = UIViewController()
		viewController.title = "Points challenge"
		viewController.view = UITableView()
		let navigationController = UINavigationController(
			rootViewController: viewController
		)
		rootWindow.rootViewController = navigationController
		rootWindow.makeKeyAndVisible()
	}

	func startMasterScreen() {
		let viewController = MasterScreen()
		let navigationController = UINavigationController(
				rootViewController: viewController
		)
		rootWindow.rootViewController = navigationController
		rootWindow.makeKeyAndVisible()
	}
}
