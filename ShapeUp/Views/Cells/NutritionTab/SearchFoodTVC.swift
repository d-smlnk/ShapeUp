//
//  SearchFoodTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 10.12.2023.
//

import UIKit

class SearchFoodTVC: UITableViewCell {
    static let reuseIdentifier = "SearchFoodTVC"
    
    var mealData: NutritionModel?
    
    private let mealNameLabel = UILabel()
    private let goToMealPageBtn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(mealNameLabel)
        contentView.backgroundColor = DS.DesignColorTemplates.secondaryColor
        contentView.superview?.backgroundColor = .clear
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        selectionStyle = .none
        
        goToMealPageBtn.setImage(UIImage(named: "GoToVC"), for: .normal)
        goToMealPageBtn.imageView?.contentMode = .scaleAspectFit
        contentView.addSubview(goToMealPageBtn)
        
        //MARK: - CONSTRAINTS
        
        mealNameLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        goToMealPageBtn.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(DS.Paddings.spacing)
            $0.width.equalTo(goToMealPageBtn.snp.height)
        }
        
    }
    
    func configure() {
        mealNameLabel.text = mealData?.name.capitalized
    }
}
