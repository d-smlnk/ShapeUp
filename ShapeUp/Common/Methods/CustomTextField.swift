//
//  Methods.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 26.10.2023.
//

import Foundation
import UIKit

func customTextField(imageName: String, placeholder: String, contentType: UITextContentType, textField: UITextField) {
    
    let textFieldCellArray: [(UIImage, String, UITextContentType, UITextField)] = [
        (UIImage(named: imageName) ?? UIImage(), placeholder, .name, textField)
    ]
    
    let textStackView = UIStackView(arrangedSubviews: textFieldCellArray.map( { item in
        
        //mainview setup
        let textField = item.3
        textField.backgroundColor = DesignColorTemplates.secondaryColor
        textField.layer.cornerRadius = SizeOFElements.customCornerRadius
        textField.isUserInteractionEnabled = true
        textField.autocapitalizationType = .none
        
        let mainViewPadding = UIView()
        
        mainViewPadding.snp.makeConstraints {
            $0.height.width.equalTo(SizeOFElements.heightForSingleElements)
        }
        
        textField.leftView = mainViewPadding
        textField.leftViewMode = .always
        
        //image setup
        let leftImageView = UIImageView()
        leftImageView.image = item.0
        
        mainViewPadding.addSubview(leftImageView)
        
        leftImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        
        //placeholder setup
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = padding.left
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Fonts.simpleTextFontSize, weight: .light),
            .foregroundColor: DesignColorTemplates.customTextColor ?? .black,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedPlaceholder = NSAttributedString(string: item.1, attributes: attributes)
        
        textField.attributedPlaceholder = attributedPlaceholder
        
        textField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        return textField
    }))
    textStackView.spacing = CGFloat(Paddings.spacing)
    textStackView.axis = .vertical
    textStackView.isUserInteractionEnabled = true
}
