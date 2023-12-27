//
//  MealInfoTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 18.12.2023.
//

import UIKit
import RealmSwift

class MealInfoTVC: UITableViewCell {
    static let reuseIdentifier = "MealInfoTVC"
    
    var foodData: RealmPickedFoodPresenter?
    
    var nutritionData: List<RealmFoodNutritionPresenter>?
    
    private let foodNameLabel = UILabel()
    private let proteinLabel = UILabel()
    private let carbsLabel = UILabel()
    private let fatLabel = UILabel()
    private let ccalLabel = UILabel()
    private let goToFoodMenuBtn = UIButton()
    private let mealSizeLabel = UILabel()
    
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
        
        foodNameLabel.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
        contentView.addSubview(foodNameLabel)
        
        ccalLabel.font = .systemFont(ofSize: DS.Fonts.separateTextFontSize, weight: .semibold)
        contentView.addSubview(ccalLabel)
        
        let nutritionArray = [proteinLabel, carbsLabel, fatLabel]
        
        nutritionArray.forEach {
            $0.font = .systemFont(ofSize: DS.Fonts.simpleTextFontSize, weight: .medium)
        }
        
        let nutritionSV = UIStackView(arrangedSubviews: nutritionArray)
        nutritionSV.axis = .horizontal
        nutritionSV.distribution = .fillEqually
        contentView.addSubview(nutritionSV)
        
        let separatorView = UIView(height: 2, color: DS.DesignColorTemplates.borderColor ?? .black, cornered: true, addTo: contentView)
        
        mealSizeLabel.textColor = .darkGray
        contentView.addSubview(mealSizeLabel)
        
        goToFoodMenuBtn.setImage(UIImage(named: "GoToFood"), for: .normal)
        contentView.addSubview(goToFoodMenuBtn)
        
        //MARK: - CONSTRAINTS
        contentView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.edges.equalToSuperview()
        }
        
        foodNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        ccalLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Paddings.padding)
            $0.trailing.equalTo(goToFoodMenuBtn.snp.leading).offset(-DS.Paddings.spacing)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(foodNameLabel.snp.bottom).offset(DS.Paddings.spacing)
        }
        
        nutritionSV.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(DS.Paddings.spacing)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
            $0.trailing.equalTo(goToFoodMenuBtn.snp.leading).offset(-Double(DS.Paddings.spacing) * 10.5)
        }
        
        mealSizeLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(DS.Paddings.spacing)
            $0.trailing.equalTo(goToFoodMenuBtn.snp.leading).offset(-DS.Paddings.spacing)
            $0.height.equalTo(nutritionSV.snp.height)
        }
        
        goToFoodMenuBtn.snp.makeConstraints {
            $0.size.equalTo(DS.SizeOFElements.heightForSingleElements / 3)
            $0.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.centerY.equalTo(ccalLabel.snp.centerY)
        }
    }

    func configure() {
        foodNameLabel.text = foodData?.name.capitalized
        
        guard let proteinNum = nutritionData?.value(forKey: "protein_g").first as? Double else { return }
        proteinLabel.text = String(format: "%.1f", proteinNum)
        
        guard let carbsNum = nutritionData?.value(forKey: "carbohydrates_total_g").first as? Double else { return }
        carbsLabel.text = String(format: "%.1f", carbsNum)
        
        guard let fatNum = nutritionData?.value(forKey: "fat_total_g").first as? Double else { return }
        fatLabel.text = String(format: "%.1f", fatNum)
        
        guard let ccalNum = nutritionData?.value(forKey: "calories").first as? Double else { return }
        ccalLabel.text = "\(String(format: "%.1f", ccalNum)) Ccal"
        
        guard let mealSizeNum = nutritionData?.value(forKey: "serving_size_g").first as? Int else { return }
        mealSizeLabel.text = ("\(mealSizeNum)g")
    }
}
