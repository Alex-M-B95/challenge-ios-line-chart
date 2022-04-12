//
//  Created by Alex.M on 11.04.2022
//  

import Foundation

struct PointsResponse: Codable {
	let points: [PointResponse]
}

struct PointResponse: Codable {
	let x: Int
	let y: Int
}
