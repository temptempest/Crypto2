//
//  CombineTableViewDataSource.swift
//  Crypto2
//
//  Created by Victor on 06.05.2024.
//

import UIKit
import Combine

final class CombineTableViewDataSource<Element>: NSObject, UITableViewDataSource {
	let build: (UITableView, IndexPath, Element) -> UITableViewCell
	var elements: [Element] = []
	
	init(builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell) {
		self.build = builder
		super.init()
	}
	
	func pushElements(_ elements: [Element], to tableView: UITableView) {
		tableView.dataSource = self
		self.elements = elements
		tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		elements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		build(tableView, indexPath, elements[indexPath.row])
	}
}

extension UITableView {
	func items<Element>(_ builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell) -> ([Element]) -> Void {
		let dataSource = CombineTableViewDataSource(builder: builder)
		return { items in
			dataSource.pushElements(items, to: self)
		}
	}
}

extension UITableViewCell {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
