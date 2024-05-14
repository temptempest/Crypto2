//
//  Image.swift
//  Crypto2
//
//  Created by Victor on 03.05.2024.
//

import UIKit

extension UIImage {
	func resized(toWidth width: CGFloat) -> UIImage? {
		let height = width // CGFloat(ceil(width / size.width * size.height))
		let canvasSize = CGSize(width: width, height: height)
		UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
		defer { UIGraphicsEndImageContext() }
		draw(in: CGRect(origin: .zero, size: canvasSize))
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}
