//
//  ExerciseListTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 06.11.2023.
//

import UIKit

class ExerciseListTVC: UITableViewCell {
    
    static let reuseIdentifier = "ExerciseListTVC"
    
    var pickedExerciseData: RealmPickedExerciseService?

    private let exerciseLabel = UILabel()
    private let dropDownMenuBtn = UIButton()
    private let exerciseIV = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {

        contentView.snp.makeConstraints {
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
            $0.edges.equalToSuperview()
        }
                
        backgroundColor = DesignColorTemplates.mainColor
        
        contentView.addSubview(exerciseIV)
        
        exerciseIV.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Paddings.padding)
            $0.width.equalTo(exerciseIV.snp.height)
        }
        
        exerciseLabel.textColor = .black
        exerciseLabel.font = .systemFont(ofSize: Fonts.smallTitleFontSize, weight: .semibold)
        
        contentView.addSubview(exerciseLabel)
        
        exerciseLabel.snp.makeConstraints {
            $0.height.equalTo(SizeOFElements.heightForSingleElements)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(exerciseIV.snp.trailing).offset(Paddings.spacing)
        }
        
        dropDownMenuBtn.addTarget(self, action: #selector(btn), for: .touchUpInside)
        contentView.addSubview(dropDownMenuBtn)
        
        dropDownMenuBtn.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(Paddings.padding)
            $0.width.equalTo(dropDownMenuBtn.snp.height)
        }
    }
    
    func configure() {
        exerciseLabel.text = pickedExerciseData?.exerciseName
        
        dropDownMenuBtn.setImage(UIImage(named: "DropDownMenu"), for: .normal)
        dropDownMenuBtn.setImage(UIImage(named: "HideDroppedMenu"), for: .selected)
    }
    
    @objc func btn() {
        dropDownMenuBtn.isSelected = !dropDownMenuBtn.isSelected
    }
}
