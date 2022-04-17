//
//  Created by Alex.M on 23.03.2022.
//

import Foundation
import UIKit

public extension UIStackView {
	func addArrangedSubviews(_ subviews: UIView...) {
		for view in subviews {
			view.translatesAutoresizingMaskIntoConstraints = false
			addArrangedSubview(view)
		}
	}

	func addArrangedSubviews(_ subviews: [UIView]) {
		for view in subviews {
			view.translatesAutoresizingMaskIntoConstraints = false
			addArrangedSubview(view)
		}
	}

	func removeAllArrangedSubviews() {
		for view in arrangedSubviews.reversed() {
			removeArrangedSubview(view)
			view.removeFromSuperview()
		}
	}

	func removeAllArrangedSubviews<T>(of type: T.Type) {
		for view in arrangedSubviews.reversed() where view is T {
			removeArrangedSubview(view)
			view.removeFromSuperview()
		}
	}

	func removeLastArrangedSubview<T>(of type: T.Type) {
		for view in arrangedSubviews.reversed() where view is T {
			removeArrangedSubview(view)
			view.removeFromSuperview()
			return
		}
	}
}
