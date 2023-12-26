//
//  NutritionInfoTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.12.2023.
//

import UIKit
import RealmSwift

class NutritionInfoTVC: UITableViewCell {
    
    static let reuseIdentifier = "NutritionInfoTVC"
    
    var realmFoodData: Results<RealmPickedFoodPresenter>?
    
    var mealTime: String?
    
    let proteinLabel = UILabel()
    let carbsLabel = UILabel()
    let fatLabel = UILabel()
    
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
        
        let nutritionArray = [proteinLabel, carbsLabel, fatLabel]
        
        nutritionArray.forEach {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .semibold)
        }
        
        let nutritionSV = UIStackView(arrangedSubviews: nutritionArray)
        nutritionSV.axis = .horizontal
        nutritionSV.distribution = .fillEqually
        contentView.addSubview(nutritionSV)
        
        dropDownMenuBtn.setImage(UIImage(named: "DropDownMenu"), for: .normal)
        dropDownMenuBtn.setImage(UIImage(named: "HideDroppedMenu"), for: .selected)
        contentView.addSubview(dropDownMenuBtn)
        
        //MARK: - CONSTRAINTS
        
        nutritionSV.snp.makeConstraints {
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(DS.Paddings.spacing)
            $0.trailing.equalTo(dropDownMenuBtn.snp.leading).offset(-DS.Paddings.spacing * 9)
        }
        
        dropDownMenuBtn.snp.makeConstraints {
            $0.height.width.equalTo(DS.SizeOFElements.heightForSingleElements / 2)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Paddings.padding)
        }
    }
    
    func configure() {
        let filteredFoodData = self.realmFoodData?.filter("mealTime == %@", mealTime ?? "")
        
        guard let proteinNum = filteredFoodData?.flatMap({ element in
            element.foodList.map { realmItem in
                realmItem.protein_g
            }
        }).reduce(0, +) else { return }

        proteinLabel.text = String(format: "%.1f", proteinNum)
        
        guard let carbsNum = filteredFoodData?.flatMap({ element in
            element.foodList.map { realmItem in
                realmItem.carbohydrates_total_g
            }
        }).reduce(0, +) else { return }
        
        carbsLabel.text = String(format: "%.1f", carbsNum)
        
        guard let fatNum = filteredFoodData?.flatMap({ element in
            element.foodList.map { realmItem in
                realmItem.fat_total_g
            }
        }).reduce(0, +) else { return }
        
        fatLabel.text = String(format: "%.1f", fatNum)
    }
    
}
