//
//  Font.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import UIKit

extension UIFont {
	func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
		let descriptor = fontDescriptor.withSymbolicTraits(traits)
		return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
	}
}
