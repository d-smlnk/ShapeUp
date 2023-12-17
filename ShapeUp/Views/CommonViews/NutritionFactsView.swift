//
//  NutritionFactsView.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 12.12.2023.
//

import Foundation
import UIKit

class NutritionFactsView: UIView {
    
    let servingSizeLbl = UILabel()
    let ccalLbl = UILabel()
    let amountPerServLbl = UILabel()
    let ccalFromFatLbl = UILabel()
    let totFatLbl = UILabel()
    let totFatNum = UILabel()
    let satFatLbl = UILabel()
    let satFatNumLbl = UILabel()
    let cholesterolLbl = UILabel()
    let cholesterolNumLbl = UILabel()
    let sodiumLbl = UILabel()
    let sodiumNumLbl = UILabel()
    let potassiumLbl = UILabel()
    let potassiumNumLbl = UILabel()
    let carbohydratesLbl = UILabel()
    let carbohydratesNumLbl = UILabel()
    let fiberLbl = UILabel()
    let fiberNumLbl = UILabel()
    let sugarNumLbl = UILabel()
    let proteinLbl = UILabel()
    let proteinNumLbl = UILabel()
    let sugarLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .white
        self.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        
        let nutritionFactsLbl = UILabel()
        nutritionFactsLbl.text = "Nutrition Facts"
        nutritionFactsLbl.textAlignment = .center
        nutritionFactsLbl.font = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .bold)
        self.addSubview(nutritionFactsLbl)
        
        self.addSubview(servingSizeLbl)
        
        let separatorView = UIView(height: 10, color: .black, cornered: false, addTo: self)

        amountPerServLbl.text = "Amount Per Serving"
        self.addSubview(amountPerServLbl)
        
        let separatorAmountPS = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        self.addSubview(ccalLbl)
        
        self.addSubview(ccalFromFatLbl)
        
        let separatorCcal = UIView(height: 6, color: .black, cornered: false, addTo: self)

        let dailyValueLbl = UILabel()
        dailyValueLbl.text = "% Daily Value"
        self.addSubview(dailyValueLbl)
        
        let dailyValSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let totalFatSV = UIStackView(arrangedSubviews: [totFatLbl, totFatNum])
        totalFatSV.distribution = .equalCentering
        self.addSubview(totalFatSV)
        
        let totalFatSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let satFatSV = UIStackView(arrangedSubviews: [satFatLbl, satFatNumLbl])
        satFatSV.distribution = .equalCentering
        self.addSubview(satFatSV)
        
        let satFatSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let cholesterolSV = UIStackView(arrangedSubviews: [cholesterolLbl, cholesterolNumLbl])
        cholesterolSV.distribution = .equalCentering
        self.addSubview(cholesterolSV)
        
        let cholesterolSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let sodiumSV = UIStackView(arrangedSubviews: [sodiumLbl, sodiumNumLbl])
        sodiumSV.distribution = .equalCentering
        self.addSubview(sodiumSV)
        
        let sodiumSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let potassiumSV = UIStackView(arrangedSubviews: [potassiumLbl, potassiumNumLbl])
        potassiumSV.distribution = .equalCentering
        self.addSubview(potassiumSV)
        
        let potassiumSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let carbohydratesSV = UIStackView(arrangedSubviews: [carbohydratesLbl, carbohydratesNumLbl])
        carbohydratesSV.distribution = .equalCentering
        self.addSubview(carbohydratesSV)
        
        let carbohydratesSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let fiberSV = UIStackView(arrangedSubviews: [fiberLbl, fiberNumLbl])
        fiberSV.distribution = .equalCentering
        self.addSubview(fiberSV)
        
        let fiberSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let sugarSV = UIStackView(arrangedSubviews: [sugarLbl, sugarNumLbl])
        sugarSV.distribution = .equalCentering
        self.addSubview(sugarSV)
        
        let sugarSeparator = UIView(height: 2, color: .black, cornered: false, addTo: self)
        
        let proteinSV = UIStackView(arrangedSubviews: [proteinLbl, proteinNumLbl])
        proteinSV.distribution = .equalCentering
        self.addSubview(proteinSV)
        
        //MARK: - CONSTRAINTS
        
        nutritionFactsLbl.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        servingSizeLbl.snp.makeConstraints {
            $0.top.equalTo(nutritionFactsLbl.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(servingSizeLbl.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        amountPerServLbl.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        separatorAmountPS.snp.makeConstraints {
            $0.top.equalTo(amountPerServLbl.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        ccalLbl.snp.makeConstraints {
            $0.top.equalTo(separatorAmountPS.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        ccalFromFatLbl.snp.makeConstraints {
            $0.top.equalTo(separatorAmountPS.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        separatorCcal.snp.makeConstraints {
            $0.top.equalTo(ccalLbl.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        dailyValueLbl.snp.makeConstraints {
            $0.top.equalTo(separatorCcal.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        dailyValSeparator.snp.makeConstraints {
            $0.top.equalTo(dailyValueLbl.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        totalFatSV.snp.makeConstraints {
            $0.top.equalTo(dailyValSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        totalFatSeparator.snp.makeConstraints {
            $0.top.equalTo(totalFatSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        satFatSV.snp.makeConstraints {
            $0.top.equalTo(totalFatSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.trailing.equalToSuperview().inset(DS.Paddings.spacing)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding * 2)
        }
        
        satFatSeparator.snp.makeConstraints {
            $0.top.equalTo(satFatSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        cholesterolSV.snp.makeConstraints {
            $0.top.equalTo(satFatSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        cholesterolSeparator.snp.makeConstraints {
            $0.top.equalTo(cholesterolSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        sodiumSV.snp.makeConstraints {
            $0.top.equalTo(cholesterolSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        sodiumSeparator.snp.makeConstraints {
            $0.top.equalTo(sodiumSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        potassiumSV.snp.makeConstraints {
            $0.top.equalTo(sodiumSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        potassiumSeparator.snp.makeConstraints {
            $0.top.equalTo(potassiumSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        carbohydratesSV.snp.makeConstraints {
            $0.top.equalTo(potassiumSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.spacing)
        }
        
        carbohydratesSeparator.snp.makeConstraints {
            $0.top.equalTo(carbohydratesSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        fiberSV.snp.makeConstraints {
            $0.top.equalTo(carbohydratesSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.trailing.equalToSuperview().inset(DS.Paddings.spacing)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding * 2)
        }
        
        fiberSeparator.snp.makeConstraints {
            $0.top.equalTo(fiberSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        sugarSV.snp.makeConstraints {
            $0.top.equalTo(fiberSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.trailing.equalToSuperview().inset(DS.Paddings.spacing)
            $0.leading.equalToSuperview().inset(DS.Paddings.padding * 2)
        }
        
        sugarSeparator.snp.makeConstraints {
            $0.top.equalTo(sugarSV.snp.bottom).offset(DS.Paddings.spacing / 2)
        }
        
        proteinSV.snp.makeConstraints {
            $0.top.equalTo(sugarSeparator.snp.bottom).offset(DS.Paddings.spacing / 2)
            $0.leading.trailing.bottom.equalToSuperview().inset(DS.Paddings.spacing)
        }
    }
    
}
