//
// Created by Alex.M on 11.04.2022.
//

import Foundation

public protocol PointsGatewayProtocol {
	func fetch(count: Int, completion: @escaping (Result<[PointModel], Error>) -> Void) -> CommandProtocol
}
