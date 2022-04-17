//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit
import ChartFeature

protocol AnyDetailDataSource: DetailViewDataSource, UITableViewRegistrarProtocol {
	var items: [CGPoint] { get }
	var sorted: Bool { get set }
}

final class DetailDataSource: NSObject, AnyDetailDataSource {
	private(set) var items: [CGPoint]
	var sorted: Bool = false {
		didSet {
			if oldValue != sorted {
				models = makeModels()
			}
		}
	}

	private lazy var models: [CGPoint] = makeModels()

	init(items: [CGPoint] = []) {
		self.items = items
		super.init()
	}
}

// MARK: - Private methods
private extension DetailDataSource {
	func makeModels() -> [CGPoint] {
		if sorted {
			return items.sorted { $0.x < $1.x }
		} else {
			return items
		}
	}
}

// MARK: - UITableViewRegistrarProtocol
extension DetailDataSource: UITableViewRegistrarProtocol {
	func registerCells(in tableView: UITableView) {
		tableView.registerCellClass(ofType: PointInfoCell.self)
	}
}

// MARK: - AppLineChartViewDataSource
extension DetailDataSource: AppLineChartViewDataSource {
	func appLineChartView(_ appLineChartView: AppLineChartView, numberOfPointsInChart index: Int) -> Int {
		models.count
	}

	func appLineChartView(_ appLineChartView: AppLineChartView, valueForChart chartIndex: Int, at pointIndex: Int) -> CGPoint {
		models[pointIndex]
	}
}

// MARK: - UITableViewDataSource
extension DetailDataSource: UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int {
		models.isEmpty ? 0 : 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = models[indexPath.row]
		let cell = tableView.dequeueReusableCell(ofType: PointInfoCell.self, at: indexPath)
		cell.config(model: item)
		return cell
	}
}
