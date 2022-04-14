//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import UIKit
import Swinject

protocol AnyResolver {
	func resolve<Service>(_ service: Service.Type) -> Service
}

var dependencies: AnyResolver {
	return DependenciesApplicationService.shared
}

final class DependenciesApplicationService: ApplicationServiceProtocol {
	static let shared = DependenciesApplicationService()

	private lazy var container = Container()
	private lazy var assembler: Assembler = makeAssembler()

	private init() {}

	func onStartApplication(_ application: UIApplication) {
		_ = assembler // Run assembler initialization
	}
}

extension DependenciesApplicationService: AnyResolver {
	func resolve<Service>(_ service: Service.Type) -> Service {
		guard let result = container.resolve(service) else {
			fatalError("Not registered dependency \(service)")
		}
		return result
	}
}

private extension DependenciesApplicationService {
	func makeAssembler() -> Assembler {
		Assembler(
				[
					GatewayAssembly(),
					FactoryAssembly(),
					PresenterAssembly(),
					ScreenAssembly()
				],
				container: container
		)
	}
}
