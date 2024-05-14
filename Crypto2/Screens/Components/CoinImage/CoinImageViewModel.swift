//
//  CoinImageViewModel.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import UIKit
import Combine

class CoinImageViewModel: ObservableObject {
	@Published var image: UIImage? = nil
	@Published var isLoading: Bool = false
	
	private let coin: Coin
	private let dataService: CoinImageService
	private var cancelables = Set<AnyCancellable>()
	
	init(coin:Coin) {
		self.coin = coin
		self.dataService = CoinImageService(coin: coin)
		self.addSubscribers()
		self.isLoading = true
	}
	
	private func addSubscribers() {
		dataService.$image
			.sink {  [weak self] (_) in
				self?.isLoading = false
			} receiveValue: { [weak self] returnedImage in
				self?.image = returnedImage
			}
			.store(in: &cancelables)
	}
}

