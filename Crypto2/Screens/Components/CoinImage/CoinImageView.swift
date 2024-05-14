//
//  CoinImageView.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import UIKit
import Combine
final class CoinImageView: UIImageView {
	var vm: CoinImageViewModel
	private var cancelables = Set<AnyCancellable>()
	init(coin:Coin) {
		vm = CoinImageViewModel(coin: coin)
		super.init(frame: .zero)
		self.contentMode = .scaleAspectFit
		
		if let image = vm.image {
			self.image = image.resized(toWidth: 30)
		} else {
			self.image = UIImage(systemName: "questionmark")
		}
		
		vm.$image
			.sink { image in
				Task { @MainActor in
					self.image = image?.resized(toWidth: 30)
				}
			}
			.store(in: &cancelables)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


#Preview("CoinImageView") {
	let iv = CoinImageView(coin: DeveloperPreview.instance.coin)
	return iv
}
