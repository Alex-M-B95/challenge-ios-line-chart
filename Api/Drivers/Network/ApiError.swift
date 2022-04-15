//
// Created by Alex.M on 15.04.2022.
//

import Foundation

enum ApiError: Error {
	case logic(statusCode: Int, data: Data?)
	case server(statusCode: Int, data: Data?)
	case unexpected(statusCode: Int, error: Error, data: Data?)
}
