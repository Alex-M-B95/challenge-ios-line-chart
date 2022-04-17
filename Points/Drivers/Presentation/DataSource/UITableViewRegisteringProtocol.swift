//
// Created by Alex.M on 07.04.2022.
//

import Foundation

public protocol UITableViewRegisteringProtocol {
	func visit(registrar: UITableViewRegistrarProtocol)
}

extension UITableViewRegisteringProtocol {
	func visit(registrar: UITableViewRegistrarProtocol?) {
		guard let registrar = registrar else { return }
		visit(registrar: registrar)
	}
}
