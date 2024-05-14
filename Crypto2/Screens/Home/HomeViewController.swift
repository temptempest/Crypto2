//
//  HomeViewController.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import SwiftUI
import UIKit
import Combine

final class HomeViewController: NiblessViewController, UITableViewDelegate {
	private var viewModel: HomeViewModel
	private var tableView: UITableView = UITableView(frame: .zero, style: .plain)
	private typealias Cell = CoinRowCell
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		bind()
	}
}

// MARK: - Binding
private extension HomeViewController {
	func bind() {
		viewModel.$allCoins
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: tableView.items { tableView, indexPath, item in
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as? CoinRowCell else { return UITableViewCell() }
				cell.configure(coin: item)
				return cell
			})
			.store(in: &viewModel.cancellabels)
	}
}

// MARK: - UITableViewDelegate
extension HomeViewController {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let binding: Binding<Coin?> = Binding {
			self.viewModel.allCoins[indexPath.item]
		} set: { newValue in }
		
		Task { @MainActor in
			let swiftUIVC = DetailLoadingView(coin: binding)
			let vc = UIHostingController(rootView: swiftUIVC)
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}

// MARK: - UI
private extension HomeViewController {
	func setupTableView() {
		tableView.delegate = self
		tableView.frame = view.bounds
		tableView.tableHeaderView = UIView()
		tableView.separatorStyle = .none
		tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
		tableView.backgroundColor = UIColor.theme.background
		view.addSubview(tableView)
	}
}

// MARK: - Preview
#Preview("Home") {
	UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel()))
}
