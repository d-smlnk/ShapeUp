//
//  MealVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 12.12.2023.
//

import UIKit

class MealVC: UIViewController, SendDateAndMealTimeDelegate {
    
    private var nutritionView = NutritionFactsView()
    private let insertGramTF = UITextField(image: UIImage(named: "MealIcon") ?? UIImage(), placeholder: "Grams", contentType: .numberPad)

    weak var nutritionData: SendNutritionDataDelegate?
    
    var delegatedData: Date?
    var delegatedMealTime: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = NutritionMainVC()
        vc.sendDateAndMealDelegate = self
        vc.sendDataToVC()
        self.dismissKeyboardOnTap()
        setupLayout()
    }
    
    private func setupLayout() {
        configure()
        view.backgroundColor = DS.DesignColorTemplates.secondaryColor
        view.addSubview(nutritionView)
        
        let nameLbl = UILabel()
        nameLbl.text = nutritionData?.nutritionDataDelegate?.name.capitalized
        nameLbl.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .bold)
        view.addSubview(nameLbl)
        
        insertGramTF.backgroundColor = DS.DesignColorTemplates.additionalColor
        view.addSubview(insertGramTF)
        
        let saveBtn = UIButton()
        saveBtn.backgroundColor = DS.DesignColorTemplates.borderColor
        saveBtn.setTitle("Save Meal", for: .normal)
        saveBtn.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        saveBtn.addTarget(self, action: #selector(saveMeal), for: .touchUpInside)
        view.addSubview(saveBtn)

        
        //MARK: - CONSTRAINTS
        
        nameLbl.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
        }
        
        insertGramTF.snp.makeConstraints {
            $0.top.equalTo(nameLbl.snp.bottom).offset(DS.Paddings.padding * 3)
            $0.leading.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
        }
        
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(insertGramTF.snp.bottom).offset(DS.Paddings.spacing * 3)
            $0.width.equalTo(view.frame.width / 2)
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.centerX.equalToSuperview()
        }
        
        nutritionView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(DS.Paddings.padding)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.width - (view.frame.width / 4))
        }

    }
    #warning("here is the commented lines")
    func configure() {
        nutritionView.servingSizeLbl.text = "Serving Size \(nutritionData?.nutritionDataDelegate?.serving_size_g ?? 0)g"
        nutritionView.ccalLbl.text = "Calories \(nutritionData?.nutritionDataDelegate?.calories ?? 0)"
//        nutritionView.ccalFromFatLbl.text = "Ccal from Fat \(ccalFromFat ?? 0)"
        nutritionView.totFatLbl.text = "Total Fat \(nutritionData?.nutritionDataDelegate?.fat_total_g ?? 0)g"
//        nutritionView.totFatNum.text = "\(totalFat_perc ?? 0)%"
        nutritionView.satFatLbl.text = "Saturated Fat \(nutritionData?.nutritionDataDelegate?.fat_saturated_g ?? 0)g"
//        nutritionView.satFatNumLbl.text = "\(satFat_perc ?? 0)%"
        nutritionView.cholesterolLbl.text = "Cholesterol \(nutritionData?.nutritionDataDelegate?.cholesterol_mg ?? 0)mg"
//        nutritionView.cholesterolNumLbl.text = "\(cholesterol_perc ?? 0)%"
        nutritionView.sodiumLbl.text = "Sodium \(nutritionData?.nutritionDataDelegate?.sodium_mg ?? 0)mg"
//        nutritionView.sodiumNumLbl.text = "\(sodium_perc ?? 0)%"
        nutritionView.potassiumLbl.text = "Potassium \(nutritionData?.nutritionDataDelegate?.potassium_mg ?? 0)mg"
//        nutritionView.potassiumNumLbl.text = "\(potassium_perc ?? 0)%"
        nutritionView.carbohydratesLbl.text = "Carbonohydrate Total \(nutritionData?.nutritionDataDelegate?.carbohydrates_total_g ?? 0)g"
//        nutritionView.carbohydratesNumLbl.text = "\(carbonohydrate_perc ?? 0)%"
        nutritionView.fiberLbl.text = "Dietary Fiber \(nutritionData?.nutritionDataDelegate?.fiber_g ?? 0)g"
//        nutritionView.fiberNumLbl.text = "\(fiber_perc ?? 0)%"
        nutritionView.sugarLbl.text = "Sugars \(nutritionData?.nutritionDataDelegate?.sugar_g ?? 0)g"
//        nutritionView.sugarNumLbl.text = "\(sugar_perc ?? 0)%"
        nutritionView.proteinLbl.text = "Protein \(nutritionData?.nutritionDataDelegate?.protein_g ?? 0)g"
//        nutritionView.proteinNumLbl.text = "\(protein_perc ?? 0)%"
    }
}

//MARK: - DELEGATE METHOD
extension MealVC {
    func sendDateAndMealDelegate(_ date: Date, _ mealTime: String) {
        delegatedData = date
        delegatedMealTime = mealTime
    }
}

//MARK: - @objc METHODS
extension MealVC {
    @objc func saveMeal() {
        let tfValue = Double(insertGramTF.text ?? "1") ?? 1
        
        let realmObject = RealmPickedFoodPresenter()
        let nutritionObject = RealmFoodNutritionPresenter()
        
        if let name =           nutritionData?.nutritionDataDelegate?.name,
           let calories =       nutritionData?.nutritionDataDelegate?.calories,
           let servingSize =    nutritionData?.nutritionDataDelegate?.serving_size_g,
           let fatTotal =       nutritionData?.nutritionDataDelegate?.fat_total_g,
           let fatSat =         nutritionData?.nutritionDataDelegate?.fat_saturated_g,
           let protein =        nutritionData?.nutritionDataDelegate?.protein_g,
           let sodium =         nutritionData?.nutritionDataDelegate?.sodium_mg,
           let pottasium =      nutritionData?.nutritionDataDelegate?.potassium_mg,
           let cholesterol =    nutritionData?.nutritionDataDelegate?.cholesterol_mg,
           let carbs =          nutritionData?.nutritionDataDelegate?.carbohydrates_total_g,
           let fiber =          nutritionData?.nutritionDataDelegate?.fiber_g,
           let sugar =          nutritionData?.nutritionDataDelegate?.sugar_g {
            
            let ccalResult = calories * tfValue / 100
            let servResult = servingSize * tfValue / 100
            let fatTotalResult = fatTotal * tfValue / 100
            let fatSatResult = fatSat * tfValue / 100
            let proteinResult = protein * tfValue / 100
            let sodiumResult = sodium * tfValue / 100
            let pottasiumResult = pottasium * tfValue / 100
            let cholesterolResult = cholesterol * tfValue / 100
            let carbsResult = carbs * tfValue / 100
            let fiberResult = fiber * tfValue / 100
            let sugarResult = sugar * tfValue / 100
            
            do {
                    try? RealmPresenter.realm.write {
                        nutritionObject.name = name
                        nutritionObject.calories = ccalResult
                        nutritionObject.serving_size_g = servResult
                        nutritionObject.fat_total_g = fatTotalResult
                        nutritionObject.fat_saturated_g = fatSatResult
                        nutritionObject.protein_g = proteinResult
                        nutritionObject.sodium_mg = sodiumResult
                        nutritionObject.potassium_mg = pottasiumResult
                        nutritionObject.cholesterol_mg = cholesterolResult
                        nutritionObject.carbohydrates_total_g = carbsResult
                        nutritionObject.fiber_g = fiberResult
                        nutritionObject.sugar_g = sugarResult
                        RealmPresenter.realm.add(nutritionObject)
                    }
                }
            } else {
                print("Found nil during fetching data from API")
            }
        
        if let delegatedData = self.delegatedData,
           let delegatedMealTime = self.delegatedMealTime,
           let name = self.nutritionData?.nutritionDataDelegate?.name {

            do {
                try? RealmPresenter.realm.write {
                    realmObject.name = name
                    realmObject.date = delegatedData
                    realmObject.mealTime = delegatedMealTime
                    realmObject.foodList.append(nutritionObject)
                    RealmPresenter.realm.add(realmObject)
                }
                print(realmObject)
            }
        } else {
            print("Found nil during delegating data")
        }
        dismiss(animated: true)
    }
}
