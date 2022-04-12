//
// Created by Alex.M on 11.04.2022.
//

import Foundation

final class FetchPointsApiCommand: ApiCommand<PointsResponse> {
	override var host: URL { URL(string: "hr-challenge.interactivestandard.com/")! }
	override var endpoint: String { "/api/test/points" }
	override var method: ApiMethod { .get }

	let count: Int

	init(count: Int, completionBlock: @escaping ApiCompletionBlock<PointsResponse>) {
		self.count = count
		super.init(completionBlock: completionBlock)
	}
}
