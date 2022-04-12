//
// Created by Alex.M on 11.04.2022.
//

import Foundation

extension Operation: CommandProtocol {
	public func execute() {
		start()
	}
}

extension OperationQueue: ExecutorProtocol {
	public func execute(command: CommandProtocol) {
		if let operation = command as? Operation {
			addOperation(operation)
		} else {
			addOperation {
				command.execute()
			}
		}
	}
}
