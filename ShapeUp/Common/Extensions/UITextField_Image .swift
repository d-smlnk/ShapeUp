//
//  Methods.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 26.10.2023.
//

import Foundation
import UIKit

extension UITextField {
    
    convenience init(image: UIImage, placeholder: String, contentType: UITextContentType) {
        self.init()
        
        let textFieldCellArray: [(UIImage, String, UITextContentType)] = [
            (image, placeholder, contentType)
        ]
        
        let textStackView = UIStackView(arrangedSubviews: textFieldCellArray.map( { item in
            
            //mainview setup
            self.backgroundColor = DS.DesignColorTemplates.secondaryColor
            self.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
            self.isUserInteractionEnabled = true
            self.autocapitalizationType = .none
            
            let mainViewPadding = UIView()
            self.leftView = mainViewPadding
            self.leftViewMode = .always
            
            //image setup
            let leftImageView = UIImageView()
            leftImageView.image = item.0
            mainViewPadding.addSubview(leftImageView)
            
            //placeholder setup
            let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.firstLineHeadIndent = padding.left
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .light),
                .foregroundColor: DS.DesignColorTemplates.customTextColor ?? .black,
                .paragraphStyle: paragraphStyle
            ]
            
            let attributedPlaceholder = NSAttributedString(string: item.1, attributes: attributes)
            self.attributedPlaceholder = attributedPlaceholder
            
            //MARK: CONSTRAINTS
            
            mainViewPadding.snp.makeConstraints {
                $0.height.width.equalTo(DS.SizeOFElements.heightForSingleElements)
            }
            
            leftImageView.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(12)
                $0.centerY.equalToSuperview()
            }
            
            self.snp.makeConstraints {
                $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
            }
            return self
        }))
        textStackView.spacing = CGFloat(DS.Paddings.spacing)
        textStackView.axis = .vertical
        textStackView.isUserInteractionEnabled = true
        
    }
}
