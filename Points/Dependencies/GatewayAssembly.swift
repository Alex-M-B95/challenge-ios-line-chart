//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import Swinject
import Domain
import Api

class GatewayAssembly: Assembly {
	func assemble(container: Container) {
		container.register(PointsGatewayProtocol.self) { resolver in
			PointsGateway()
		}
	}
}
