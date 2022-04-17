//
// Created by Alex.M on 11.04.2022.
//

import Foundation

public protocol CommandProtocol {
	func execute()
}

public protocol RetryableCommandProtocol: CommandProtocol {
	func canRetry() -> Bool
	func retry()
}

public extension RetryableCommandProtocol {
	func retryIfCan() -> Bool {
		guard canRetry() else { return false }
		retry()
		return true
	}
}
