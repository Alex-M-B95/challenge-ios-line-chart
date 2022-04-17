//
// Created by Alex.M on 03.09.2021.
//

import Foundation

public protocol Reusable: class {
	static var reuseId: String {get}
}

public extension Reusable {
	static var reuseId: String {
		return String(describing: self)
	}

	static var bundle: Bundle {
		return Bundle(for: self)
	}
}
