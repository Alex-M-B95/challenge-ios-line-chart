//
// Created by Alex.M on 14.04.2022.
//

import Foundation

public protocol UseCaseFactoryProtocol {
	func getPoints(count: Int, onResult: @escaping (Result<[PointModel], GetPointsError>) -> Void) -> GetPointsCaseProtocol
}

public final class UseCaseFactory: UseCaseFactoryProtocol {
	let pointsGateway: PointsGatewayProtocol

	public init(pointsGateway: PointsGatewayProtocol) {
		self.pointsGateway = pointsGateway
	}

	public func getPoints(count: Int, onResult: @escaping (Result<[PointModel], GetPointsError>) -> Void) -> GetPointsCaseProtocol {
		GetPointsCase(
				count: count,
				gateway: pointsGateway,
				onResult: onResult
		)
	}
}
