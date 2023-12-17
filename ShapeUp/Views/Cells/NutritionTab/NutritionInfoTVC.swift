//
//  NutritionInfoTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.12.2023.
//

import UIKit

class NutritionInfoTVC: UITableViewCell {
    
    static let reuseIdentifier = "NutritionInfoTVC"
    
    let mealLabel = UILabel()
    let dropDownMenuBtn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.superview?.backgroundColor = .clear
        contentView.backgroundColor = DS.DesignColorTemplates.additionalColor
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        selectionStyle = .none
        
        mealLabel.textColor = .black
        mealLabel.font = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .semibold)
        contentView.addSubview(mealLabel)
        
        dropDownMenuBtn.setImage(UIImage(named: "DropDownMenu"), for: .normal)
        dropDownMenuBtn.setImage(UIImage(named: "HideDroppedMenu"), for: .selected)
        contentView.addSubview(dropDownMenuBtn)
        
        //MARK: - CONSTRAINTS
        
        mealLabel.snp.makeConstraints {
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(DS.Paddings.spacing)
        }
        
        dropDownMenuBtn.snp.makeConstraints {
            $0.height.width.equalTo(DS.SizeOFElements.heightForSingleElements / 2)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
    }
    
}
