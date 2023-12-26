//
//  NutritionMainTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 08.12.2023.
//

import UIKit
import RealmSwift

class NutritionMainTVC: UITableViewCell {
    
    static let reuseIdentifier = "NutritionMainTVC"
    
    var mealData: (String, UIImage?)?
    
    var mealTime: String?
    
    var realmFoodData: Results<RealmPickedFoodPresenter>?
    
    private let mealIV = UIImageView()
    private let mealTitle = UILabel()
    let ccalNumTitle = UILabel()
    let ccalTitle = UILabel()
    let addMealBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.superview?.backgroundColor = .clear
        contentView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        selectionStyle = .none

        mealIV.contentMode = .scaleAspectFit
        contentView.addSubview(mealIV)
        
        mealTitle.textColor = DS.DesignColorTemplates.customTextColor
        mealTitle.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
        contentView.addSubview(mealTitle)
        
        ccalNumTitle.textColor = DS.DesignColorTemplates.customTextColor
        ccalNumTitle.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
        
        ccalTitle.textColor = DS.DesignColorTemplates.customTextColor
        ccalTitle.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .regular)
        
        let ccalSV = UIStackView(arrangedSubviews: [ccalNumTitle, ccalTitle])
        ccalSV.distribution = .fillEqually
        ccalSV.axis = .vertical
        addSubview(ccalSV)
        
        addMealBtn.setImage(UIImage(named: "AddExercise"), for: .normal)
        addSubview(addMealBtn)
        
        //MARK: - CONSTRAINTS
        
        mealIV.snp.makeConstraints {
            $0.size.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.top.leading.bottom.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        mealTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(mealIV.snp.trailing).offset(DS.Paddings.padding)
        }
        
        addMealBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(DS.SizeOFElements.heightForSingleElements / 2)
            $0.trailing.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        ccalSV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(addMealBtn.snp.leading).offset(-DS.Paddings.padding)
        }
    }
    
    func configure() {
        mealIV.image = mealData?.1
        mealTitle.text = mealData?.0
        ccalTitle.text = "Ccal"
        
        let filteredFoodData = self.realmFoodData?.filter("mealTime == %@", mealTime ?? "")
        
        guard let ccalNum = filteredFoodData?.flatMap({ element in
            element.foodList.map { realmItem in
                realmItem.calories
            }
        }).reduce(0, +) else { return }

        ccalNumTitle.text = String(format: "%.1f", ccalNum)
    }
    
}
