//
// Created by Alex.M on 11.04.2022.
//

import Foundation
import Domain
import Alamofire

typealias ApiCompletionBlock<T> = (_ command: CommandProtocol, _ result: Result<T, Error>) -> Void

enum ApiMethod {
	case get
	case post

	internal func toAlamofireMethod() -> HTTPMethod {
		switch self {
		case .get:
			return .get
		case .post:
			return .post
		}
	}
}

class ApiCommand<Response: Decodable>: CommandProtocol {
	// MARK: - Values
	private lazy var fullRequestString: String = {
		host.appendingPathComponent(endpoint).absoluteString
	}()

	var host: URL {
		fatalError("Need override method name")
	}

	var endpoint: String {
		fatalError("Need override method name")
	}

	var method: ApiMethod {
		fatalError("Need override parameters")
	}

	var parameterEncoding: Alamofire.ParameterEncoding {
		switch method {
		case .get:
			return URLEncoding()
		default:
			return JSONEncoding()
		}
	}

	var headers: [String: String] {
		return [:]
	}

	var parameters: [String: Any] {
		return [:]
	}

	let completionBlock: ApiCompletionBlock<Response>

	// MARK: - Object life cycle
	init(completionBlock: @escaping ApiCompletionBlock<Response>) {
		self.completionBlock = completionBlock
	}

	// MARK: - Command methods
	func execute() {
		let request = makeRequest()
		request.resume()
	}
}

// MARK: - Private methods
private extension ApiCommand {
	func makeRequest() -> Request {
		AF
			.request(
				host.appendingPathComponent(endpoint),
				method: method.toAlamofireMethod(),
				parameters: parameters,
				encoding: parameterEncoding,
				headers: HTTPHeaders(headers),
				interceptor: nil,
				requestModifier: nil
			)
			.responseDecodable(
				of: Response.self,
				completionHandler: { [weak self] response in
					self?.onCompletion(response)
				}
			)
	}

	func onCompletion(_ response: AFDataResponse<Response>) {
		guard let statusCode = response.response?.statusCode else {
			fatalError()
		}
		switch statusCode {
		case 200...299:
			switch response.result {
			case .success(let model):
				completionBlock(self, .success(model))
			case .failure(let error):
				completionBlock(self, .failure(error))
			}
		case 400...499:
			fatalError()
		case 500...599:
			fatalError()
		default:
			fatalError()
		}
	}
}
