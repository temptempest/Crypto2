//
//  Color.swift
//  Crypto
//
//  Created by Victor  on 29.11.2022.
//

import UIKit
import SwiftUI

extension UIColor {
    static let theme = UIColorTheme()
    static let launch = UILaunchTheme()
}

struct UIColorTheme {
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "BackgroundColor")
    let green = UIColor(named: "GreenColor")
    let red = UIColor(named: "RedColor")
    let secondaryText = UIColor(named: "SecondaryTextColor")
}

struct UILaunchTheme {
    let background = UIColor(named: "LaunchBackgroundColor")
    let accent = UIColor(named: "LaunchAccentColor")
}


//
extension Color {
	static let theme = ColorTheme()
	static let launch = LaunchTheme()
}

struct ColorTheme {
	let accent = Color("AccentColor")
	let background = Color("BackgroundColor")
	let green = Color("GreenColor")
	let red = Color("RedColor")
	let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
	let background = Color("LaunchBackgroundColor")
	let accent = Color("LaunchAccentColor")
}
