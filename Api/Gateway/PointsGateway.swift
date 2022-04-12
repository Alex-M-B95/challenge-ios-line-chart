//
//  Created by Alex.M on 11.04.2022
//  

import Foundation
import Domain

public final class PointsGateway: PointsGatewayProtocol {
	public func fetch(count: Int,
					  completion: @escaping (Result<[PointModel], Error>) -> Void)
	-> CommandProtocol {
		FetchPointsApiCommand(count: count) { [weak self, completion] command, result in
			self?.onFetchPoints(command: command, result: result, completion: completion)
		}
	}
}

private extension PointsGateway {
	func onFetchPoints(command: CommandProtocol,
					   result: Result<PointsResponse, Error>,
					   completion: @escaping (Result<[PointModel], Error>) -> Void) {
		switch result {
		case .success(let response):
			let points = response.points
				.compactMap { PointModel(x: $0.x, y: $0.y) }
			completion(.success(points))
		case .failure(let error):
			completion(.failure(error))
		}
	}
}
