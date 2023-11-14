//
//  ChooseMuscleForNewExerciseTVC.swift
//  ShapeUp
//
//  Created by Дима Самойленко on 31.10.2023.
//

import UIKit

class ChooseMuscleForNewExerciseTVC: UITableViewCell {
    
    static let reuseIdentifier = "ChooseMuscleForNewExerciseTVC"

    var musclesGroup: (UIImage, String)?
    private let muscleImage = UIImageView()
    private let muscleGroupLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        muscleImage.image = musclesGroup?.0
        muscleGroupLabel.text = musclesGroup?.1
    }

    
    private func setupLayout() {
        contentView.superview?.backgroundColor = DS.DesignColorTemplates.secondaryColor
        contentView.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        contentView.superview?.clipsToBounds = true
        contentView.superview?.layer.cornerRadius = DS.SizeOFElements.customCornerRadius
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.edges.equalToSuperview()
        }
        
        muscleImage.contentMode = .scaleAspectFit
        
        contentView.addSubview(muscleImage)
        
        muscleImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(DS.Paddings.padding)
            $0.width.equalTo(40)
        }
        
        muscleGroupLabel.text = musclesGroup?.1
        muscleGroupLabel.font = .systemFont(ofSize: DS.Fonts.titleFontSize, weight: .heavy)
        muscleGroupLabel.textColor = DS.DesignColorTemplates.customTextColor
        
        contentView.addSubview(muscleGroupLabel)
        
        muscleGroupLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(muscleImage.snp.trailing).offset(DS.Paddings.spacing)
        }
        
        let goNextBtn = UIButton()
        goNextBtn.setImage(UIImage(named: "GoNext"), for: .normal)
        goNextBtn.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
        
        contentView.addSubview(goNextBtn)
        
        goNextBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Paddings.padding)
            $0.height.width.equalTo(50)
        }
    }
    
    @objc private func presentVC() {
        ChooseMuscleForNewExerciseVC().halfScreenPresent(CreateExerciseVC())
    }

}
