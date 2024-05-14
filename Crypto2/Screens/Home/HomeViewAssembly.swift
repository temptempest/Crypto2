//
//  HomeViewAssembly.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import UIKit

final class HomeViewAssembly {
	static func configure() -> UIViewController {
		let vm = HomeViewModel()
		let vc = HomeViewController(viewModel: vm)
		return UINavigationController(rootViewController: vc)
	}
}
