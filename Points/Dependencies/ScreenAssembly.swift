//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import Swinject

class ScreenAssembly: Assembly {
	func assemble(container: Container) {
		container.register(MasterScreen.self) { resolver in
			var presenter = resolver.resolve(MasterPresenterProtocol.self)!
			let screen = MasterScreen(presenter: presenter)
			presenter.view = screen
			return screen
		}
	}
}
