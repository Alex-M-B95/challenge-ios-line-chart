//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit
import SnapKit
import Charts

public final class AppLineChartView: UIView {
	// MARK: - Views
	private lazy var lineChartView = LineChartView()

	// MARK: - Values
	public weak var delegate: AppLineChartViewDelegate?
	public weak var dataSource: AppLineChartViewDataSource? {
		didSet {
			reloadData()
		}
	}

	// MARK: - Object life cycle
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	// MARK: - Config
	public func reloadData() {
		guard let dataSource = dataSource else {
			clearChart()
			return
		}
		let chartData = LineChartData()
		for chartIndex in 0...dataSource.numberOfCharts(in: self) - 1 {
			let title = delegate?.appLineChartView(self, titleForChart: chartIndex) ?? "График \(chartIndex + 1)"
			let dataSet = LineChartDataSet(label: title)
			for pointIndex in 0...dataSource.appLineChartView(self, numberOfPointsInChart: chartIndex) - 1 {
				let point = dataSource.appLineChartView(self, valueForChart: chartIndex, at: pointIndex)
				let dataEntry = ChartDataEntry(x: point.x, y: point.y)
				if !dataSet.addEntryOrdered(dataEntry) {
					fatalError()
				}
			}
			let color = delegate?.appLineChartView(self, colorsForChart: chartIndex) ?? .black
			dataSet.colors = [color]
			dataSet.drawCirclesEnabled = false
			chartData.addDataSet(dataSet)
		}

		lineChartView.data = chartData
	}
}

// MARK: - Private methods
private extension AppLineChartView {
	func setupUI() {
		lineChartView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(lineChartView)
		lineChartView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview()
			make.leading.trailing.equalToSuperview()
		}
	}

	func clearChart() {
		lineChartView.clear()
	}
}
