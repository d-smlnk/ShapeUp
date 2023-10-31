//
//  Extensions.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 20.10.2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: Int) {
        if (hex > 0xFFFFFF || hex < 0x000000) {
            return nil
        }
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
