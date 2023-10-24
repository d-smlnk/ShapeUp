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

//extension UITextField {
//    convenience init(placeholder: String) {
//        self.init()
//        
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.red.cgColor
//        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
//        border.borderWidth = width
//        layer.addSublayer(border)
//        layer.masksToBounds = true
//        self.placeholder = placeholder
//    }
//}
