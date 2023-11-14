//
//  File.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 31.10.2023.
//

import Foundation
import UIKit

struct DS {
    
    struct DesignColorTemplates {
        static let mainColor = UIColor(hex: 0x08FFC8)
        static let secondaryColor = UIColor(hex: 0xD5EEBB)
        static let borderColor = UIColor(hex: 0x5F7A61)
        static let customTextColor = UIColor(hex: 0x444941)
    }
    
    struct Paddings {
        static let padding = 16
        static let spacing = 8
    }

    struct SizeOFElements {
        static let heightForSingleElements = 50
        static let customBorderWidth: CGFloat = 2
        static let customCornerRadius: CGFloat = 10
    }
    
    struct Fonts {
        static let simpleTextFontSize: CGFloat = 15
        static let separateTextFontSize: CGFloat = 17
        static let smallTitleFontSize: CGFloat = 20
        static let titleFontSize: CGFloat = 25
    }
    
}

