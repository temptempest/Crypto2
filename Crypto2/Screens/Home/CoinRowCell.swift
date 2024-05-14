//
//  CoinRowCell.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import UIKit

final class CoinRowCell: UITableViewCell {
	let showHoldingsColumn: Bool = false
	
	private var coinMaskView = UIImageView()
	private lazy var rankLabel = makeLabel(style: .caption1, color: UIColor.theme.secondaryText, alignment: .left)
	private lazy var symbolLabel = makeLabel(style: .headline, color: UIColor.theme.accent, alignment: .left, traits: .traitBold)
	private lazy var currentHoldingsValueLabel = makeLabel(style: .footnote, color: UIColor.theme.accent, traits: .traitBold)
	private lazy var currentHoldingsLabel = makeLabel(style: .footnote, color: UIColor.theme.accent)
	private lazy var currentPriceLabel = makeLabel(style: .footnote, color: UIColor.theme.accent, traits: .traitBold)
	private lazy var priceChangePercentage24HLabel = makeLabel(style: .footnote, color: UIColor.theme.accent)
	
	private lazy var hStackView = makeHStackView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func configure(coin: Coin) {
		coinMaskView.contentMode = .scaleAspectFit
		coinMaskView.image = CoinImageView(coin: coin).image
		rankLabel.text = String(coin.rank)
		symbolLabel.text = coin.symbol.uppercased()
		currentHoldingsValueLabel.text = coin.currentHoldingsValue.asCurrencyWith2Decimals()
		currentHoldingsLabel.text = (coin.currentHoldings ?? 0).asNumberString()
		currentPriceLabel.text = coin.currentPrice.asCurrencyWith6Decimals()
		priceChangePercentage24HLabel.text = coin.priceChangePercentage24H?.asPercentString()
		priceChangePercentage24HLabel.textColor = (coin.priceChange24H ?? 0) >= 0 ? UIColor.theme.green : UIColor.theme.red
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
	}
}

// MARK: - UI
private extension CoinRowCell {
	func setupUI() {
		selectionStyle = .none
		contentView.addSubview(hStackView)
		hStackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			hStackView.topAnchor.constraint(equalTo: topAnchor),
			hStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
		])
	}
	
	func makeLabel(style: UIFont.TextStyle, color: UIColor?, alignment: NSTextAlignment = .center, traits: UIFontDescriptor.SymbolicTraits = .classMask) -> UILabel {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: style).withTraits(traits: traits)
		label.textColor = color
		label.textAlignment = alignment
		return label
	}
	
	func makeLeftColumnHStack() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [rankLabel, coinMaskView, symbolLabel])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = 8
		
		let fixStackView = UIStackView(arrangedSubviews: [stackView, UIView()])
		fixStackView.axis = .vertical
		fixStackView.alignment = .leading
		return fixStackView
	}
	
	func makeCenterColumnHStack() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [currentHoldingsValueLabel, currentHoldingsLabel])
		stackView.axis = .vertical
		stackView.alignment = .trailing
		return stackView
	}
	
	func makeRightColumnHStack() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [currentPriceLabel, priceChangePercentage24HLabel])
		stackView.axis = .vertical
		stackView.alignment = .trailing
		return stackView
	}
	
	func makeHStackView() -> UIStackView {
		let leftColumn = makeLeftColumnHStack()
		let centerColumn = makeCenterColumnHStack()
		let rightColumn = makeRightColumnHStack()
		let stackView = UIStackView(arrangedSubviews: [leftColumn, centerColumn, rightColumn])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.alignment = .firstBaseline
		return stackView
	}
}

#Preview("CoinRow") {
	let cell = CoinRowCell(style: .default, reuseIdentifier: CoinRowCell.reuseIdentifier)
	cell.configure(coin: DeveloperPreview.instance.coin)
	return cell
}
