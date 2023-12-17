//
//  WorkoutHeaderCellTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 25.11.2023.
//

import UIKit

class WorkoutHeaderCellTVC: UITableViewCell {
    static let reuseIdentifier = "WorkoutHeaderCellTVC"
    
    let dropDownMenuBtn = UIButton()
    let exerciseLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = DS.DesignColorTemplates.mainColor
        selectionStyle = .none

        exerciseLabel.textColor = .black
        exerciseLabel.font = .systemFont(ofSize: DS.Fonts.smallTitleFontSize, weight: .semibold)
        contentView.addSubview(exerciseLabel)
        
        dropDownMenuBtn.setImage(UIImage(named: "DropDownMenu"), for: .normal)
        dropDownMenuBtn.setImage(UIImage(named: "HideDroppedMenu"), for: .selected)
        contentView.addSubview(dropDownMenuBtn)
        
        //MARK: - CONSTRAINTS
        
        exerciseLabel.snp.makeConstraints {
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
