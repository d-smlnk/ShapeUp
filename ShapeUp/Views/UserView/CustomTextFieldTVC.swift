//
//  CustomTextFieldTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 21.10.2023.
//

import UIKit

class CustomTextFieldTVC: UITableViewCell {
    
    var dataArray: (UITextField?, String?)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldTVC {
    
    func configure(with data: (UITextField, String)) {
        contentView.backgroundColor = .clear
        dataArray.0 = data.0
        dataArray.0?.backgroundColor = secondaryColor
        dataArray.0?.layer.cornerRadius = customCornerRadius
        dataArray.0?.layer.borderWidth = customBorderWidth
        dataArray.0?.layer.borderColor = borderColor?.cgColor
        
        let mainViewPadding = UIView.init(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        dataArray.0?.leftView = mainViewPadding
        dataArray.0?.leftViewMode = .always

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: customTextColor ?? .black,
        ]
        
        let attributedPlaceholder = NSAttributedString(string: data.1, attributes: attributes)
        
        data.0.attributedPlaceholder = attributedPlaceholder
        
        contentView.addSubview(dataArray.0 ?? UITextField())
        
        dataArray.0?.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(spacingElements)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(heightForSingleElements)
        }
    }
}
