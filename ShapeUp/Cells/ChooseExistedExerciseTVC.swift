//
//  ChooseExistedExerciseTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 03.11.2023.
//

import UIKit
import RealmSwift

class ChooseExistedExerciseTVC: UITableViewCell {
    
    static let reuseIdentifier = "ChooseExistedExerciseTVC"
    
    let exerciseNameLabel = UILabel()
    var realmData : RealmExerciseService?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        exerciseNameLabel.text = realmData?.exerciseName
    }
    
    private func setupLayout() {
        backgroundColor = DS.DesignColorTemplates.secondaryColor
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(DS.SizeOFElements.heightForSingleElements)
            $0.edges.equalToSuperview()
        }
        
        let addExerciseBtn = UIButton()
        addExerciseBtn.setImage(UIImage(named: "AddExercise"), for: .normal)
        
        contentView.addSubview(addExerciseBtn)
        
        addExerciseBtn.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Paddings.padding)
        }
        
        contentView.addSubview(exerciseNameLabel)
        
        exerciseNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(DS.Paddings.padding)
        }
        
    }
}
