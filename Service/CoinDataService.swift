//
//  CoinDataService.swift
//  Crypto
//
//  Created by Victor  on 29.11.2022.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
		let localCoinsData = UserDefaults.standard.object(forKey: "coinsLocally")
		if localCoinsData != nil {
			getCoinsFromStorage()
		} else {
			getCoinsFromInterner()
			print("block")
		}
    }
}

extension CoinDataService {
	func getCoinsFromStorage()  {
		do {
			let data: Data = UserDefaults.standard.object(forKey: "coinsLocally") as! Data
			let decoder = JSONDecoder()
			let coins = try decoder.decode([Coin].self, from: data)
			self.allCoins = coins
		} catch {
			self.allCoins = []
		}
	}
	
	func getCoinsFromInterner() {
		let urlString = Constant.coinGecko.hostUrl + Constant.coinGecko.coinsListPath + Constant.coinGecko.coinsListQuery
		guard let url = URL(string: urlString) else { return }
		coinSubscription = NetworkingManager.download(url: url)
			.tryMap {
				let data: Data = $0
				UserDefaults.standard.set(data, forKey: "coinsLocally")
				return data
			}
			.decode(type: [Coin].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] returnedCoins in
				self?.allCoins = returnedCoins
				self?.coinSubscription?.cancel()
			})
	}
}
