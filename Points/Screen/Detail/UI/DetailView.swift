//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit
import ChartFeature

protocol DetailViewDataSource: UITableViewDataSource, AppLineChartViewDataSource {}

enum DetailViewStyle {
	case table
	case chart
}

protocol DetailViewDelegate: UITableViewDelegate, AppLineChartViewDelegate {
	func didChangeViewStyle(_ style: DetailViewStyle)
}

final class DetailView: UIView {
	// MARK: - Views
	private lazy var tableView = UITableView()
	private lazy var chartView = AppLineChartView()
	private lazy var segmentView = UISegmentedControl(items: segmentItems)

	// MARK: - Values
	private lazy var segmentItems = ["Список", "График"]
	weak var dataSource: DetailViewDataSource? {
		didSet {
			tableView.dataSource = dataSource
			chartView.dataSource = dataSource
		}
	}

	weak var delegate: DetailViewDelegate? {
		didSet {
			tableView.delegate = delegate
			chartView.delegate = delegate
		}
	}

	// MARK: - Object life cycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}

	// MARK: - Config
	func reloadData() {
		tableView.reloadData()
		chartView.reloadData()
	}

	func configLandscape() {
		segmentView.snp.updateConstraints { make in
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
		}
	}

	func configPortrait() {
		segmentView.snp.updateConstraints { make in
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(16)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(16)
		}
	}
}

extension DetailView: UITableViewRegisteringProtocol {
	public func visit(registrar: UITableViewRegistrarProtocol) {
		registrar.registerCells(in: tableView)
	}
}

// MARK: - Private methods
private extension DetailView {
	func setupUI() {
		backgroundColor = .white
		addSubviews(segmentView, tableView, chartView)

		segmentView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(16)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(16)
		}
		segmentView.selectedSegmentIndex = 0
		segmentView.addTarget(self, action: #selector(onChangeSegment), for: .valueChanged)

		tableView.snp.makeConstraints { make in
			make.top.equalTo(segmentView.snp.bottom)
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
			make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
		}
		chartView.snp.makeConstraints { make in
			make.top.equalTo(segmentView.snp.bottom)
			make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
			make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
			make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
		}
		chartView.isHidden = true
	}

	@objc
	func onChangeSegment(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			tableView.isHidden = false
			chartView.isHidden = true
			delegate?.didChangeViewStyle(.table)
		case 1:
			tableView.isHidden = true
			chartView.isHidden = false
			delegate?.didChangeViewStyle(.chart)
		default:
			debugPrint("[DetailView.segmentView] Incorrect selected index")
			sender.selectedSegmentIndex = 0
			onChangeSegment(sender: sender)
		}
	}
}
