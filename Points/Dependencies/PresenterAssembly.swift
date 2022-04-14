//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import Swinject
import Domain

class PresenterAssembly: Assembly {
	func assemble(container: Container) {
		container.register(MasterPresenterProtocol.self) { resolver in
			MasterPresenter(
					useCaseFactory: resolver.resolve(UseCaseFactoryProtocol.self)!
			)
		}
	}
}
