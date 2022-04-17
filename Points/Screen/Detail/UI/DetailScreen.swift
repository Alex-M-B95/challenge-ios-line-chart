//
// Created by Alex.M on 17.04.2022.
//

import Foundation
import UIKit

final class DetailScreen: UIViewController {
	// MARK: - Views
	private lazy var rootView = DetailView()
	private lazy var sortView = DetailSortSwitchView()
	private lazy var sortNavigationItem = UIBarButtonItem(customView: sortView)

	// MARK: - Values
	/*weak*/ var dataSource: AnyDetailDataSource?

	// MARK: - Object life cycle
	init(dataSource: AnyDetailDataSource?) {
		self.dataSource = dataSource
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		debugPrint(String(describing: type(of: self)), "deinit")
	}

	// MARK: - UIViewController life cycle
	override func loadView() {
		view = rootView
		setupUI()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		rootView.reloadData()
	}

	// MARK: - UIViewController overrides
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		configOrientation()
	}
}

// MARK: - Private methods
private extension DetailScreen {
	func setupUI() {
		title = "Точки"
		rootView.visit(registrar: dataSource)
		rootView.dataSource = dataSource
		rootView.delegate = self
		configOrientation()

		sortView.addTarget(self, action: #selector(onChangeSort))
		navigationItem.setRightBarButton(sortNavigationItem, animated: false)
	}

	func configOrientation() {
		if UIDevice.current.orientation.isLandscape {
			rootView.configLandscape()
		} else {
			rootView.configPortrait()
		}
	}

	@objc
	func onChangeSort() {
		dataSource?.sorted = sortView.isOn
		rootView.reloadData()
	}
}

// MARK: - DetailViewDelegate
extension DetailScreen: DetailViewDelegate {
	func didChangeViewStyle(_ style: DetailViewStyle) {
		switch style {
		case .table:
			navigationItem.setRightBarButton(sortNavigationItem, animated: false)
		case .chart:
			navigationItem.setRightBarButton(nil, animated: false)
		}
	}
}
