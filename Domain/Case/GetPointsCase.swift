//
// Created by Alex.M on 11.04.2022.
//

import Foundation

public protocol GetPointsCaseProtocol: RetryableCommandProtocol {}

public final class GetPointsCase: AppOperation, GetPointsCaseProtocol {
	let count: Int
	let gateway: PointsGatewayProtocol
	let onResult: (Result<[PointModel], GetPointsError>) -> Void

	private lazy var runCount: Int = 0
	private lazy var executor = OperationQueue()

	public init(count: Int,
				gateway: PointsGatewayProtocol,
				onResult: @escaping (Result<[PointModel], GetPointsError>) -> Void) {
		self.count = count
		self.gateway = gateway
		self.onResult = onResult
		super.init()
		ready()
	}

	deinit {
		debugPrint(String(describing: type(of: self)), "deinit")
	}

	public override func main() {
		super.main()
		guard !isCancelled else { return }
		runCount += 1
		debugPrint(String(describing: type(of: self)), "try num", runCount)

		let command = gateway.fetch(count: count) { [weak self] result in
			self?.onFetch(result)
		}
		executor.execute(command: command)
	}

	public override func canRetry() -> Bool {
		super.canRetry() && runCount < 3
	}
}

private extension GetPointsCase {
	func onFetch(_ result: Result<[PointModel], GetPointsError>) {
		var isFinish = true
		defer {
			if isFinish {
				finish()
			}
		}

		switch result {
		case .success(let model):
			if !model.isEmpty {
				onResult(.success(model))
			} else {
				onResult(.failure(.emptyPoints))
			}
		case .failure(let error):
			if case .networkTrouble = error {
				if retryIfCan() {
					isFinish = false
				} else {
					onResult(.failure(.networkTrouble))
				}
			} else {
				onResult(.failure(error))
			}
		}
	}
}
