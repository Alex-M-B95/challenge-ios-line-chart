//
// Created by Alex.M on 03.09.2021.
//

import UIKit

public protocol ReusableCell: Reusable {}
extension UITableViewCell: ReusableCell {}
extension UICollectionViewCell: ReusableCell {}

public extension UITableView {
	func dequeueReusableCell<T: ReusableCell>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T {
		guard
				let cell = dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T
				else { fatalError() }
		return cell
	}

	func dequeueReusableCell<T: ReusableCell>(ofType cellType: T.Type = T.self) -> T {
		guard
				let cell = dequeueReusableCell(withIdentifier: cellType.reuseId) as? T
				else { fatalError() }
		return cell
	}

	func registerCellNib<Type: ReusableCell>(ofType type: Type.Type) {
		let bundle = Bundle(for: type)
		let nibCell = UINib(nibName: type.reuseId, bundle: bundle)
		self.register(nibCell, forCellReuseIdentifier: type.reuseId)
	}

	func registerCellClass<Type: ReusableCell>(ofType type: Type.Type) {
		self.register(type, forCellReuseIdentifier: type.reuseId)
	}
}

public extension UICollectionView {
	func dequeueReusableCell<T: ReusableCell>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T {
		guard
				let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T
				else { fatalError() }
		return cell
	}

	func registerCellNib<Type: ReusableCell>(ofType type: Type.Type) {
		let bundle = Bundle(for: type)
		let nibCell = UINib(nibName: type.reuseId, bundle: bundle)
		self.register(nibCell, forCellWithReuseIdentifier: type.reuseId)
	}

	func registerCellClass<Type: ReusableCell>(ofType type: Type.Type) {
		self.register(type, forCellWithReuseIdentifier: type.reuseId)
	}
}
