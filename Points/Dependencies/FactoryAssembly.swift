//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import Swinject
import Domain

class FactoryAssembly: Assembly {
	func assemble(container: Container) {
		container.register(UseCaseFactoryProtocol.self) { resolver in
			UseCaseFactory(
					pointsGateway: resolver.resolve(PointsGatewayProtocol.self)!
			)
		}
	}
}
