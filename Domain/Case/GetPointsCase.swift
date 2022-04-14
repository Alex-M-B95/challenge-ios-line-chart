//
// Created by Alex.M on 11.04.2022.
//

import Foundation

public protocol GetPointsCaseProtocol: CommandProtocol {}

public final class GetPointsCase: Operation, GetPointsCaseProtocol {
	let count: Int
	let gateway: PointsGatewayProtocol
	let onResult: (Result<[PointModel], GetPointsError>) -> Void

	private lazy var executor = OperationQueue()

	public init(count: Int,
				gateway: PointsGatewayProtocol,
				onResult: @escaping (Result<[PointModel], GetPointsError>) -> Void) {
		self.count = count
		self.gateway = gateway
		self.onResult = onResult
	}

	public override func start() {
		let command = gateway.fetch(count: count) { [weak self] result in
			self?.onFetch(result)
		}
		executor.execute(command: command)
	}
}

private extension GetPointsCase {
	func onFetch(_ result: Result<[PointModel], Error>) {
		switch result {
		case .success(let model):
			if !model.isEmpty {
				onResult(.success(model))
			} else {
				onResult(.failure(.unknown(NSError(domain: "Empty", code: -1))))
			}
		case .failure(let error):
			onResult(.failure(.unknown(error)))
		}
	}
}
