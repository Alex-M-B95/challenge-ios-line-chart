//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit.UIColor

public protocol AppLineChartViewDelegate: AnyObject {
	func appLineChartView(_ appLineChartView: AppLineChartView, colorsForChart index: Int) -> UIColor
	func appLineChartView(_ appLineChartView: AppLineChartView, titleForChart index: Int) -> String
}

public extension AppLineChartViewDelegate {
	func appLineChartView(_ appLineChartView: AppLineChartView, colorsForChart index: Int) -> UIColor { .black }
	func appLineChartView(_ appLineChartView: AppLineChartView, titleForChart index: Int) -> String { "График \(index + 1)" }
}
