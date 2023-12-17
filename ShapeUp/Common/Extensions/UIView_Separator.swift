//
//  UIView_Separator.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 12.12.2023.
//

import Foundation
import UIKit

extension UIView {
    convenience init(height: CGFloat, color: UIColor, cornered: Bool?, addTo view: UIView) {
        self.init()
        
        self.backgroundColor = color
        cornered ?? false ? self.layer.cornerRadius = DS.SizeOFElements.customCornerRadius : nil
        
        view.addSubview(self)
        
        self.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.trailing.leading.equalToSuperview().inset(DS.Paddings.spacing)
        }
    }
}

