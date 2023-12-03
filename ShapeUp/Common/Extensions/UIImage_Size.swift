//
//  UIImage_Size.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 27.11.2023.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { image in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
