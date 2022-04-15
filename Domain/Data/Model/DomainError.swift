//
// Created by Alex.M on 11.04.2022.
//

import Foundation

public enum GetPointsError: Error {
	case networkTrouble
	case wrongParameters
	case emptyPoints
	case unknown(Error)
}
