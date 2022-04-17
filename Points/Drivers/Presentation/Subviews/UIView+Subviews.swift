//
//  Created by Alex.M on 23.03.2022.
//

import Foundation
import UIKit

public extension UIView {
	func addSubviews(_ subviews: UIView...) {
		for view in subviews {
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
		}
	}
}
