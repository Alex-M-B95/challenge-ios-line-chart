//
//  Created by Alex.M on 17/09/2019.
//  Copyright © 2019 theinvaders. All rights reserved.
//

import Foundation

open class AppOperation: Operation {
	// MARK: Lifecycle
	public override init() {
		super.init()
	}

	deinit {}

	// MARK: Statuses
	public var status: AppOperationStatus = .pending {
		didSet {
			innerStatus = status.toInnerStatus()
		}
	}

	private var innerStatus: InnerStatus = .pending {
		willSet {
			willChangeValue(forKey: innerStatus.keyPath)
			willChangeValue(forKey: newValue.keyPath)
		}
		didSet {
			didChangeValue(forKey: oldValue.keyPath)
			didChangeValue(forKey: innerStatus.keyPath)
		}
	}

	private var didCancel: Bool = false

	// MARK: Default Operation Variables
	open override var isReady: Bool {
		return super.isReady && innerStatus == .ready
	}
	open override var isFinished: Bool {
		return innerStatus == .finished
	}
	open override var isExecuting: Bool {
		return innerStatus == .executing
	}
	open override var isCancelled: Bool {
		return super.isCancelled && (didCancel || innerStatus == .cancelled)
	}

	// MARK: Default Operation Methods
	open override func start() {
		guard !isCancelled else { return }
		main()
	}

	open override func main() {
		guard !isCancelled else { return }
		status = .executing
	}

	open override func cancel() {
		guard !isCancelled else { return }
		super.cancel()
		status = .cancelled
		didCancel = true
		finish()
	}

	public func finish() {
		status = .finished
	}

	public func ready() {
		guard status == .pending else { return }
		status = .ready
	}
}

// MARK: Statuses
extension AppOperation {
	fileprivate enum InnerStatus: String {
		case pending, ready, executing, finished, cancelled

		var keyPath: String {
			return "is" + rawValue.capitalized
		}
	}
}

extension AppOperationStatus {
	fileprivate func toInnerStatus() -> AppOperation.InnerStatus {
		switch self {
		case .pending:
			return .pending
		case .ready:
			return .ready
		case .executing:
			return .executing
		case .cancelled:
			return .cancelled
		case .finished, .failed:
			return .finished
		}
	}
}
