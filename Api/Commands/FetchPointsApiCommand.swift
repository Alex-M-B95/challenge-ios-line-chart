//
// Created by Alex.M on 11.04.2022.
//

import Foundation

final class FetchPointsApiCommand: ApiCommand<PointsResponse> {
	override var host: URL { URL(string: "https://hr-challenge.interactivestandard.com/")! }
	override var endpoint: String { "api/test/points" }
	override var method: ApiMethod { .get }
	override var parameters: [String: Any] {
		["count": count]
	}

	let count: Int

	init(count: Int, completionBlock: @escaping ApiCompletionBlock<PointsResponse>) {
		self.count = count
		super.init(resultBlock: completionBlock)
	}

	deinit {
		debugPrint(String(describing: type(of: self)), "deinit")
	}
}
