//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import Domain

protocol MasterPresenterProtocol {
	func submit(points count: Int)
}

final class MasterPresenter: MasterPresenterProtocol {
	let useCaseFactory: UseCaseFactoryProtocol
	private lazy var queue = OperationQueue()

	init(useCaseFactory: UseCaseFactoryProtocol) {
		self.useCaseFactory = useCaseFactory
	}

	func submit(points count: Int) {
		let command = useCaseFactory.getPoints(count: count) { [weak self] result in
			self?.onGetPoints(result)
		}
		queue.execute(command: command)
	}
}

private extension MasterPresenter {
	func onGetPoints(_ result: Result<[PointModel], GetPointsError>) {
		switch result {
		case .success(let model):
			print(model)
			// TODO: Handle success
			break
		case .failure(let error):
			print(error)
			// TODO: Handle error
			break
		}
	}
}
