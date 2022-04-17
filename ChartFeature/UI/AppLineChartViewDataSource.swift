//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import CoreGraphics.CGGeometry

public protocol AppLineChartViewDataSource: AnyObject {
	func numberOfCharts(in appLineChartView: AppLineChartView) -> Int
	func appLineChartView(_ appLineChartView: AppLineChartView, numberOfPointsInChart index: Int) -> Int
	func appLineChartView(_ appLineChartView: AppLineChartView, valueForChart chartIndex: Int, at pointIndex: Int) -> CGPoint
}

public extension AppLineChartViewDataSource {
	func numberOfCharts(in appLineChartView: AppLineChartView) -> Int { 1 }
}
