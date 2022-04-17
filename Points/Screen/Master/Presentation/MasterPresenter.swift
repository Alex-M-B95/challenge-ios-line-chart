//
// Created by Alex.M on 14.04.2022.
//

import Foundation
import UIKit
import Domain

protocol MasterPresenterProtocol {
	var view: MasterViewInput? { get set }

	func submit(points count: Int)
}

final class MasterPresenter: MasterPresenterProtocol {
	let useCaseFactory: UseCaseFactoryProtocol
	private lazy var queue = OperationQueue()

	weak var view: MasterViewInput?

	init(useCaseFactory: UseCaseFactoryProtocol) {
		self.useCaseFactory = useCaseFactory
	}

	deinit {
		debugPrint(String(describing: type(of: self)), "deinit")
	}

	func submit(points count: Int) {
		let command = useCaseFactory.getPoints(count: count) { [weak self] result in
			self?.onGetPoints(result)
		}
		queue.execute(command: command)
	}
}

private extension MasterPresenter {
	func handleError(error: GetPointsError) {
		switch error {
		case .networkTrouble:
			view?.showError(error: "Сервер временно недоступен. Попробуйте позже.")
		case .wrongParameters:
			view?.showError(error: "Неверное значение. Измените значение и попробуйте ещё раз")
		case .emptyPoints:
			view?.showError(error: "Точек не найдено. Попробуйте с другим количеством.")
		case .unknown(let reason):
			print(String(describing: reason))
			print(reason.localizedDescription)
			view?.showError(error: "Неизвестная ошибка. Попробуйте позже.")
		}
	}

	func onGetPoints(_ result: Result<[PointModel], GetPointsError>) {
		switch result {
		case .success(let model):
			let items = model.map { CGPoint(x: $0.x, y: $0.y) }
			view?.navigateToDetail(items: items)
		case .failure(let error):
			handleError(error: error)
		}
	}
}
