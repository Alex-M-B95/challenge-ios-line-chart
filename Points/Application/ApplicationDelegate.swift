//
//  Created by Alex.M on 11.04.2022.
//

import UIKit

@main
class ApplicationDelegate: UIResponder, UIApplicationDelegate {
	private let services: [ApplicationServiceProtocol] = [
		DependenciesApplicationService.shared,
		GuiApplicationService()
	]

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		for service in services {
			service.onStartApplication(application)
		}
		return true
	}
}
